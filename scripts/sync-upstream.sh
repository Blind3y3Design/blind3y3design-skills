#!/usr/bin/env bash
# Re-copy each skill listed in upstream.json from its creator's repo.
# A skill's syncedFrom commit is updated only when its files actually changed.
# Set SYNC_SUMMARY to a file path to get a Markdown list of what changed.
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
manifest="$root/upstream.json"
summary=${SYNC_SUMMARY:-/dev/null}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

: > "$summary"
count=$(jq '.skills | length' "$manifest")

for i in $(seq 0 $((count - 1))); do
  name=$(jq -r ".skills[$i].name" "$manifest")
  repo=$(jq -r ".skills[$i].repo" "$manifest")
  ref=$(jq -r ".skills[$i].ref" "$manifest")
  path=$(jq -r ".skills[$i].path" "$manifest")
  old=$(jq -r ".skills[$i].syncedFrom" "$manifest")
  license_from=$(jq -r ".skills[$i].license.from // empty" "$manifest")
  license_to=$(jq -r ".skills[$i].license.to // empty" "$manifest")

  src="$tmp/$i"
  git clone --quiet --depth 1 --branch "$ref" "https://github.com/$repo.git" "$src"
  new=$(git -C "$src" rev-parse HEAD)

  if [ ! -f "$src/$path/SKILL.md" ]; then
    echo "error: $repo@$ref has no $path/SKILL.md; did the skill move?" >&2
    exit 1
  fi

  rsync -a --delete --exclude .git "$src/$path/" "$root/skills/$name/"
  watched=("skills/$name")
  if [ -n "$license_from" ]; then
    cp "$src/$license_from" "$root/$license_to"
    watched+=("$license_to")
  fi

  if [ -n "$(git -C "$root" status --porcelain -- "${watched[@]}")" ]; then
    jq --indent 2 ".skills[$i].syncedFrom = \"$new\"" "$manifest" > "$tmp/manifest.json"
    mv "$tmp/manifest.json" "$manifest"
    echo "- \`$name\` from [$repo](https://github.com/$repo/tree/$new/$path): [compare changes](https://github.com/$repo/compare/$old...$new)" >> "$summary"
    echo "$name: updated from $repo@${new:0:7}"
  else
    echo "$name: no changes"
  fi
done
