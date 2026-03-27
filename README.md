# Growth

Everyone's growth is unique.

This repository manages **project documentation**, **directory layout**, and **repeatable setup scripts** for local AI-assisted animation workflows (e.g. ComfyUI + open checkpoints). It is licensed under **GPL-3.0** (see [LICENSE](LICENSE)).

---

## New machine: `git clone` + one Cursor chat (recommended)

**Goal:** After you clone this repo and open it as the **Cursor workspace**, you should only need **one assistant conversation** that reads **this README** and runs the rest. You do **not** have to manually follow every step unless something requires **your** login (e.g. Hugging Face gated models).

### What you do

1. **Clone** this repository and **open the folder** in Cursor (File → Open Folder).
2. **New chat** → paste the **prompt block below** (fill in GPU if asked).
3. Wait for the assistant to run setup (terminal may run for a long time while downloading PyTorch and models).

### What the assistant should do (in order)

1. Read **this `README.md`** end-to-end.
2. Read and execute **[docs/ENVIRONMENT_SETUP.md](docs/ENVIRONMENT_SETUP.md)** on **Windows**: Git, Python 3.11, VC++ redistributable if needed, **ComfyUI** under `./ComfyUI`, **PyTorch with CUDA 12.8** (`cu128`), `pip install -r ComfyUI/requirements.txt`. Prefer running **[scripts/setup-windows.ps1](scripts/setup-windows.ps1)** from the **repository root** when appropriate; fix errors and retry.
3. Read **[docs/MODELS.md](docs/MODELS.md)** and download **missing** weights with `hf download` into `ComfyUI/models/...`, skipping files that already exist. Use the copy-paste rules at the top of `MODELS.md` if you need a shorter model-only pass.
4. Verify GPU: `python -c "import torch; print(torch.cuda.is_available(), torch.cuda.get_device_name(0) if torch.cuda.is_available() else '')"` inside `ComfyUI\venv`.
5. Report a short summary: installed paths, anything skipped (gated / login), how to start ComfyUI (`python main.py` in `ComfyUI` with venv active).

### Prompt to paste into Cursor (after `git clone`)

```text
我已经把本仓库克隆到本地并用 Cursor 打开了仓库根目录。请按该仓库 README.md 里「New machine」一节列出的顺序，自动完成环境与模型：先读 README.md，再读 docs/ENVIRONMENT_SETUP.md 与 docs/MODELS.md，用终端执行（优先 scripts/setup-windows.ps1），并用 hf 下载缺失模型。仅在需要 Hugging Face 登录或许可时再告诉我操作。我的显卡是：（在此填写，如 RTX 5080）。
```

**English variant (if your chat is English-only):**

```text
I cloned this repo and opened it as the Cursor workspace. Follow the numbered checklist under "New machine" in README.md: read README.md, then docs/ENVIRONMENT_SETUP.md and docs/MODELS.md, run scripts/setup-windows.ps1 when appropriate, and hf download missing models. Only stop for HF auth or license acceptance. My GPU is: (fill in).
```

---

## Repository layout

| Path | Purpose |
|------|--------|
| [docs/](docs/) | **[ENVIRONMENT_SETUP.md](docs/ENVIRONMENT_SETUP.md)**, **[MODELS.md](docs/MODELS.md)** (weights + links) |
| [scripts/](scripts/) | Windows bootstrap: **[setup-windows.ps1](scripts/setup-windows.ps1)** |
| [animation/](animation/) | Animation projects, story structure, exported workflows |
| [assets/](assets/) | Reference materials you own or may redistribute (keep licenses in mind) |
| `ComfyUI/` | Local [ComfyUI](https://github.com/comfyanonymous/ComfyUI) install (**not** in Git; created by setup) |

## Git vs. full environment

| In Git | Not in Git (by design) |
|--------|-------------------------|
| Docs, scripts, workflows, **`animation/renders/`** (your outputs) | `ComfyUI/` app + `venv` + downloaded `.safetensors` |

`git clone` / `git pull` only updates **tracked** files. **Weights** are downloaded again (or copied) per **MODELS.md** unless you bring your own backup.

## Remote

[jasonwong3709/Growth](https://github.com/jasonwong3709/Growth)

## Extra: smaller handoff snippets

- Model download only: top of [docs/MODELS.md](docs/MODELS.md)  
- Legacy short handoff: [docs/CURSOR_HANDOFF.md](docs/CURSOR_HANDOFF.md)
