# ComfyUI 本地模型清单与下载方式

本机 ComfyUI 根目录：**`c:\MyGrowth\ComfyUI`**（若你换过路径，把下表中的 `ComfyUI\models\` 换成你的实际路径）。

---

## 用 Cursor Chat 自动下载（不必手点浏览器）

可以。**下次在新机器上**，装好 Python/ComfyUI/`venv` 并装好 `huggingface_hub[cli]` 后，**新开一条 Cursor 对话**，把下面整段复制进去（按你的路径改第一行）：

```text
请读取本仓库中的 docs/MODELS.md，按其中表格与 Hugging Face 链接，用终端为我下载「当前缺失」的模型到 ComfyUI 的 models 子目录。

规则：
1. ComfyUI 根目录：<在此填写，例如 c:\MyGrowth\ComfyUI>
2. 先激活该目录下的 venv，再使用 hf download；若缺少 hf 命令则 pip install "huggingface_hub[cli]"。
3. 每个文件下载前检查目标路径是否已存在且大小合理，已存在则跳过。
4. 若仓库需要许可或登录，提示我完成 hf auth login 或网页接受许可后重试。
5. 完成后简要列出 diffusion_models、checkpoints、text_encoders、vae、loras 中与本清单相关的文件。
```

Cursor 里的助手会按 `MODELS.md` 里的仓库名、路径和 CLI 示例去执行下载（需要本机已联网、磁盘空间足够）。

**说明：** 助手只能在你当前工作区里操作；请 **先 `git pull` 本仓库** 或把含 `MODELS.md` 的仓库打开为 Cursor 工作区，这样对话才能读到该文件。

---

约定：

- **只把权重放在 `ComfyUI\models\` 下对应子目录**；不要长期堆在 `Downloads`（避免重复占用空间）。
- 大文件推荐用 **Hugging Face CLI**（在 `ComfyUI\venv` 中已随环境安装）：  
  `hf download <repo> <path-in-repo> --local-dir <目标目录>`

---

## 1. 文生图（SD 1.5 / SDXL）

| 文件 | 放置路径 | 说明 |
|------|----------|------|
| `v1-5-pruned-emaonly.safetensors` | `models\checkpoints\` | SD 1.5 |

**下载（任选其一）：**

- 浏览器：[runwayml/stable-diffusion-v1-5](https://huggingface.co/runwayml/stable-diffusion-v1-5/tree/main) → `v1-5-pruned-emaonly.safetensors`
- CLI（示例）：

```powershell
cd c:\MyGrowth\ComfyUI
.\venv\Scripts\Activate.ps1
hf download runwayml/stable-diffusion-v1-5 v1-5-pruned-emaonly.safetensors --local-dir models\checkpoints
```

| 文件 | 放置路径 | 说明 |
|------|----------|------|
| `sd_xl_base_1.0.safetensors` | `models\checkpoints\` | SDXL base |

- 浏览器：[stabilityai/stable-diffusion-xl-base-1.0](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0)（需在网页上接受许可）
- CLI：

```powershell
hf download stabilityai/stable-diffusion-xl-base-1.0 sd_xl_base_1.0.safetensors --local-dir models\checkpoints
```

---

## 2. 文生图（Z-Image Turbo）

官方说明：[ComfyUI Examples — Z Image](https://comfyanonymous.github.io/ComfyUI_examples/z_image/)

| 文件 | 放置路径 |
|------|----------|
| `z_image_turbo_bf16.safetensors` | `models\diffusion_models\` |
| `qwen_3_4b.safetensors` | `models\text_encoders\` |
| `ae.safetensors`（Flux VAE） | `models\vae\` |

**Hugging Face 打包仓库（Comfy 拆分件）：**  
[Comfy-Org/z_image_turbo](https://huggingface.co/Comfy-Org/z_image_turbo/tree/main/split_files)

对应直链目录：

- [diffusion_models](https://huggingface.co/Comfy-Org/z_image_turbo/tree/main/split_files/diffusion_models)
- [text_encoders](https://huggingface.co/Comfy-Org/z_image_turbo/tree/main/split_files/text_encoders)
- [vae](https://huggingface.co/Comfy-Org/z_image_turbo/tree/main/split_files/vae)

推荐：打开 [Comfy-Org/z_image_turbo / split_files](https://huggingface.co/Comfy-Org/z_image_turbo/tree/main/split_files)，在 `diffusion_models`、`text_encoders`、`vae` 子目录中下载上表三个文件到对应目录。

（`hf download` 对嵌套路径因仓库结构而异；若使用 CLI，请用 `hf download --help` 并对照仓库内文件路径。）

---

## 3. 文生视频（Wan 2.2，14B T2V）

官方说明：[ComfyUI Examples — Wan 2.2](https://comfyanonymous.github.io/ComfyUI_examples/wan22/)  
补充文档：[Comfy Docs — Wan 2.2](https://docs.comfy.org/tutorials/video/wan/wan2_2)

**Hugging Face 主仓库：**  
[Comfy-Org/Wan_2.2_ComfyUI_Repackaged](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/tree/main/split_files)

### 3.1 文本编码 + VAE（14B T2V 共用）

| 文件 | 放置路径 |
|------|----------|
| `umt5_xxl_fp8_e4m3fn_scaled.safetensors` | `models\text_encoders\` |
| `wan_2.1_vae.safetensors` | `models\vae\` |

- [text_encoders 目录](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/tree/main/split_files/text_encoders)
- [vae / wan_2.1_vae](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/blob/main/split_files/vae/wan_2.1_vae.safetensors)

### 3.2 双阶段扩散（T2V 14B 必有一对）

| 文件 | 放置路径 |
|------|----------|
| `wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors` | `models\diffusion_models\` |
| `wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors` | `models\diffusion_models\` |

- [high_noise 直链](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/blob/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors)
- [low_noise 直链](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/blob/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors)
- [diffusion_models 总目录](https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/tree/main/split_files/diffusion_models)

### 3.3 可选加速 LoRA（LightX2V 4 steps）

| 文件 | 放置路径 |
|------|----------|
| `wan2.2_t2v_lightx2v_4steps_lora_v1.1_high_noise.safetensors` | `models\loras\` |
| `wan2.2_t2v_lightx2v_4steps_lora_v1.1_low_noise.safetensors` | `models\loras\` |

一般在同一 Repackaged 仓库的 **`split_files/loras`** 下（若路径变更，以 HF 网页为准）。

### 3.4 工作流 JSON

- [text_to_video_wan22_14B.json](https://comfyanonymous.github.io/ComfyUI_examples/wan22/text_to_video_wan22_14B.json)

### 3.5 CLI 批量下载示例（Wan 2.2 14B T2V 全套）

在 `ComfyUI` 下激活 `venv` 后执行（文件名须与 HF 仓库一致）：

```powershell
$repo = "Comfy-Org/Wan_2.2_ComfyUI_Repackaged"
hf download $repo split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --local-dir models\text_encoders
hf download $repo split_files/vae/wan_2.1_vae.safetensors --local-dir models\vae
hf download $repo split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors --local-dir models\diffusion_models
hf download $repo split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors --local-dir models\diffusion_models
```

LoRA 若存在 `split_files/loras/` 下，按网页文件名下载到 `models\loras\`。

---

## 4. 图生视频（Wan 2.2 14B I2V）——若未下载可跳过

要做 **Image→Video**（14B），还需要 **额外一对** low/high 噪声的 **I2V** 权重，且通常需要 **`clip_vision`**（例如 `clip_vision_h.safetensors`）。详见同一 [Wan 2.2 官方页](https://comfyanonymous.github.io/ComfyUI_examples/wan22/) 的 *Image to Video* 小节。

| 典型文件 | 放置路径 |
|----------|----------|
| `wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors` | `models\diffusion_models\` |
| `wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors` | `models\diffusion_models\` |
| `clip_vision_h.safetensors` | `models\clip_vision\` |

Wan **2.1** 资源索引（含 `clip_vision`、480p/720p 等）：  
[Comfy-Org/Wan_2.1_ComfyUI_repackaged](https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/tree/main/split_files)

---

## 5. 新机器快速自检

在 `ComfyUI` 目录下用资源管理器或 PowerShell 检查这些路径是否存在对应文件：

```text
models\checkpoints\          → SD1.5 / SDXL
models\diffusion_models\     → Z-Image；Wan 2.2 T2V（high+low）
models\text_encoders\        → qwen_3_4b（Z-Image）；umt5_xxl…（Wan）
models\vae\                  → ae（Z-Image）；wan_2.1_vae（Wan 2.2 14B）
models\loras\                → Wan LightX2V（可选）
models\clip_vision\          → 仅 I2V 等流程需要
```

安装 Hugging Face CLI（若尚未安装）：

```powershell
cd c:\MyGrowth\ComfyUI
.\venv\Scripts\Activate.ps1
pip install "huggingface_hub[cli]"
```

---

## 6. 许可与条款

各模型在 Hugging Face 上可能有 **独立许可**（商业用途、署名等）。下载前请阅读对应模型卡。本文仅汇总 **Comfy 官方示例** 中的路径与链接，不替代各模型许可证文本。
