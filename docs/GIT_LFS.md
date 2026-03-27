# Git LFS (optional)

Use this when **`animation/renders/`** contains files that are large but still under your workflow (e.g. long `mp4`, huge `zip` of frames). [GitHub](https://docs.github.com/repositories/working-with-files/managing-large-files/about-git-large-file-storage) recommends Git LFS for binaries you want in the repo without bloating normal Git objects.

## Install

- Windows: `winget install GitHub.GitLFS` (or install from [git-lfs.com](https://git-lfs.com/))
- Then once per machine: `git lfs install`

## Typical track rules (example)

From the repository root:

```powershell
git lfs track "*.mp4"
git lfs track "*.mov"
git lfs track "*.mkv"
git lfs track "*.zip"
```

This creates/updates `.gitattributes`. Commit **both** `.gitattributes` and your renders.

## Limits

GitHub LFS has storage and bandwidth quotas on free accounts; check current [GitHub billing docs](https://docs.github.com/billing) if you push many gigabytes.

## If you skip LFS

Keep individual files **under 100 MB** (GitHub block), or store only **smaller** proxies in Git and keep terabyte caches elsewhere.
