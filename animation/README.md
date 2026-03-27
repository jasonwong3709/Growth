# Animation

Put **project-level** work here: treatments, shot lists, timing notes, exported ComfyUI workflow JSON files, and **render outputs** you want to sync across machines.

## Suggested layout

| Path | Use |
|------|-----|
| `projects/<name>/` | One folder per film / episode / experiment |
| `projects/<name>/brief.md` | Story and visual direction (your original writing) |
| `workflows/` | Exported ComfyUI graphs (`.json`) |
| `renders/<project-slug>/` | **Final clips and image sequences** — **tracked in Git** so you can `git pull` on another PC and continue the same job |

## Large files and GitHub

GitHub blocks pushes for files **larger than 100 MB**. For heavy video or thousands of EXR/PNG frames, either:

- split into smaller commits / smaller exports, or  
- use **[Git LFS](https://git-lfs.com/)** (`git lfs install` then `git lfs track "*.mp4"` etc.) so binaries are stored as LFS objects.

See [docs/GIT_LFS.md](../docs/GIT_LFS.md) for a minimal optional setup.

## Naming

Use a short slug, e.g. `projects/pilot-2026-03/`, `projects/short-winter-field/`.
