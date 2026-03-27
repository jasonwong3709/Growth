# Environment setup (Windows + NVIDIA GPU)

Use this document **in a new Cursor chat on a new machine** to recreate the same local stack: Git, Python, ComfyUI, PyTorch (CUDA 12.8 for RTX 50 / Blackwell), and open diffusion checkpoints.

**Scope:** Repeatable dev environment. It does **not** replace reading ComfyUI’s own readme if upstream changes.

---

## 1. What you get after setup

- **ComfyUI** under `<repo-root>\ComfyUI` (default layout used by `scripts/setup-windows.ps1`).
- **PyTorch** with **CUDA 12.8** wheels (`cu128`) — recommended for **RTX 5080** (sm_120).
- **Checkpoints** (large files) under `ComfyUI\models\checkpoints\` — downloaded separately; **not** stored in Git.

---

## 2. Prerequisites

- Windows 10/11 x64.
- **NVIDIA driver** new enough for your GPU (for RTX 50-series, use the driver version recommended by NVIDIA for CUDA 12.x).
- **Internet** for Python packages and Hugging Face downloads.
- **Disk:** plan **30 GB+** free (PyTorch + SDXL + extras).

Optional but recommended: **Visual C++ 2015–2022 Redistributable (x64)** — PyTorch may fail to load `c10.dll` without it.

```powershell
winget install Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
```

---

## 3. Clone this repository

```powershell
cd $env:USERPROFILE\source   # or any folder you prefer
git clone https://github.com/jasonwong3709/Growth.git MyGrowth
cd MyGrowth
```

If the folder already contains only docs/scripts, that is expected. **ComfyUI appears only after** you run the setup script or manual steps below.

---

## 4. Automated setup (recommended)

From **PowerShell** (not necessarily admin), repo root:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
.\scripts\setup-windows.ps1
```

What the script does (high level):

1. Ensures **Git** and **Python 3.11** via `winget` if missing.
2. Clones **ComfyUI** into `.\ComfyUI` if absent.
3. Creates `ComfyUI\venv`, installs **PyTorch cu128**, then `pip install -r ComfyUI\requirements.txt`.
4. Downloads **open checkpoints** into `ComfyUI\models\checkpoints\` via Hugging Face CLI.

If a step fails, read the error, then use **Section 5** to do the same manually.

---

## 5. Manual setup (if you prefer or script failed)

### 5.1 Install Git and Python 3.11

```powershell
winget install Git.Git Python.Python.3.11 --accept-package-agreements --accept-source-agreements
```

Close and reopen the terminal so `PATH` updates (or refresh user `PATH` in the current session).

### 5.2 Clone ComfyUI

```powershell
cd <repo-root>
git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git ComfyUI
```

### 5.3 Python venv and dependencies

```powershell
cd ComfyUI
python -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
pip install -r requirements.txt
```

### 5.4 Download open models (example)

Still inside `ComfyUI` with venv activated:

```powershell
hf download runwayml/stable-diffusion-v1-5 v1-5-pruned-emaonly.safetensors --local-dir models\checkpoints
hf download stabilityai/stable-diffusion-xl-base-1.0 sd_xl_base_1.0.safetensors --local-dir models\checkpoints
```

**Note:** Some models on Hugging Face require accepting a license in the browser once; log in with `hf auth login` if prompted.

### 5.5 Start ComfyUI

```powershell
cd <repo-root>\ComfyUI
.\venv\Scripts\Activate.ps1
python main.py
```

Browser: **http://127.0.0.1:8188**

You can also use `<repo-root>\ComfyUI\start_comfyui.bat` if present.

---

## 6. RTX 5080 / Blackwell (sm_120)

- Prefer **PyTorch `cu128`** builds (see commands above). Older `cu124`-only stacks may warn that **sm_120** is unsupported.
- If you see **CUDA kernel** errors after an upgrade, reinstall PyTorch with the **same** CUDA wheel family as your driver stack, then retry.

---

## 7. What belongs in Git for this project

| Commit to Git | Do **not** commit |
|-----------------|-------------------|
| `docs/`, `scripts/`, `README.md`, `.gitignore` | `ComfyUI/venv/`, huge weights |
| Small **exported** ComfyUI workflows JSON under `animation/workflows/` | Rendered `mp4` / image sequences under `animation/renders/` (ignored by default) |
| Text briefs, shot lists, **your** original art | Third-party assets you are not allowed to redistribute |

`.gitignore` already excludes common large/binary paths.

---

## 8. Cursor usage hint

Paste for the assistant:

> Read `docs/ENVIRONMENT_SETUP.md` and the repo `README.md`, then help me finish or fix setup on this machine. My GPU is \<model\>. I am on Windows.

---

## 9. Troubleshooting

| Symptom | Things to try |
|--------|----------------|
| `python` not found | Reopen terminal after `winget`; or use full path under `%LocalAppData%\Programs\Python\` |
| PyTorch DLL / `c10.dll` | Install **VC++ Redistributable x64** (Section 2) |
| `hf` not found | `pip install huggingface_hub` inside `ComfyUI\venv` |
| Out of VRAM | Lower resolution in ComfyUI; use SD1.5; enable model offloading in workflow |

---

## 10. References

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [PyTorch get started](https://pytorch.org/get-started/locally/)
- Project remote: [jasonwong3709/Growth](https://github.com/jasonwong3709/Growth)

---

## 11. First-time Git (if this folder was not created by `git clone`)

If you built the tree locally and need to connect [jasonwong3709/Growth](https://github.com/jasonwong3709/Growth):

```powershell
cd <repo-root>
git init
git remote add origin https://github.com/jasonwong3709/Growth.git
git add .
git status
git commit -m "Initial project layout and environment documentation"
git branch -M main
git push -u origin main
```

If `origin` already exists, use `git remote set-url origin https://github.com/jasonwong3709/Growth.git` instead of `add`.

---

## 12. New Cursor session

See [CURSOR_HANDOFF.md](CURSOR_HANDOFF.md) for a short block you can paste into a new chat.
