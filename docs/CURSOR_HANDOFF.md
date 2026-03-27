# Cursor handoff (paste into a new chat)

Copy everything below the line into a **new Cursor chat** on a **new Windows machine** after cloning this repo.

---

**Instructions for the AI**

1. Read `README.md` and `docs/ENVIRONMENT_SETUP.md` in this repository.
2. Help the user complete or repair the local setup: Git, Python 3.11, ComfyUI under `./ComfyUI`, PyTorch with CUDA 12.8 (`cu128`), and optional checkpoint downloads per the doc.
3. Respect `.gitignore`: do not suggest committing `venv/`, `ComfyUI/`, or huge `.safetensors`. **`animation/renders/` is meant to be tracked** so the user can continue the same project on another machine; suggest Git LFS if files approach GitHub size limits.
4. Ask for the user’s **GPU model** and **Windows version** if troubleshooting CUDA.

**User context**

- Repository: [jasonwong3709/Growth](https://github.com/jasonwong3709/Growth)
- Goal: local AI animation workflow; project files live under `animation/` and `assets/`.

---
