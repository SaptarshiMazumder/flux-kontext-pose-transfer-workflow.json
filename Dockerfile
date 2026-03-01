# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-easy-use@1.3.6 --mode remote
RUN comfy node install --exit-on-fail cg-use-everywhere@7.7.0
RUN comfy node install --exit-on-fail comfyui-impact-subpack@1.3.5
RUN comfy node install --exit-on-fail comfyui-impact-pack@8.28.2
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.3.1
RUN comfy node install --exit-on-fail comfyui-unload-model@1.0.2
RUN comfy node install --exit-on-fail comfyui_layerstyle@2.0.38
RUN comfy node install --exit-on-fail comfyui_controlnet_aux@1.1.4
RUN comfy node install --exit-on-fail comfyui_essentials@1.1.0
RUN comfy node install --exit-on-fail comfyui-crystools@1.27.4
# Could not determine registry status / install command for ComfyUI_Comfyroll_CustomNodes (metadata missing) - skipping
# Could not resolve unknown_registry custom nodes for cloning: no aux_id provided for any unknown node entries

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/stable-diffusion-3.5-fp8/resolve/main/text_encoders/clip_l.safetensors --relative-path models/clip --filename clip_l.safetensors
RUN comfy model download --url https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors --relative-path models/clip --filename t5xxl_fp8_e4m3fn.safetensors
RUN comfy model download --url https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt --relative-path models/ultralytics/bbox --filename hand_yolov8s.pt
RUN comfy model download --url https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt --relative-path models/ultralytics/bbox --filename face_yolov8m.pt
RUN comfy model download --url https://huggingface.co/depth-anything/Depth-Anything-V2-Large/resolve/main/depth_anything_v2_vitl.pth --relative-path models/checkpoints --filename depth_anything_v2_vitl.pth
# RUN # Could not find URL for flux/FLUX.1-dev-ControlNet-Union-Pro-2.0.safetensors
# RUN # Could not find URL for yolox_l.onnx
# RUN # Could not find URL for dw-ll_ucoco_384_bs5.torchscript.pt
RUN comfy model download --url https://huggingface.co/Comfy-Org/flux1-kontext-dev_ComfyUI/resolve/main/split_files/diffusion_models/flux1-dev-kontext_fp8_scaled.safetensors --relative-path models/diffusion_models --filename flux1-dev-kontext_fp8_scaled.safetensors
# RUN # Could not find URL for flux kontext/refcontrol_pose.safetensors
RUN comfy model download --url https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_normalbae_fp16.safetensors --relative-path models/controlnet/1.5 --filename control_v11p_sd15_normalbae_fp16.safetensors
# RUN # Could not find URL for realisticVisionV60B1_v51VAE.safetensors
RUN comfy model download --url https://huggingface.co/ByteDance/Hyper-SD/resolve/main/Hyper-SD15-8steps-lora.safetensors --relative-path models/loras/sd15 --filename Hyper-SD15-8steps-lora.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
