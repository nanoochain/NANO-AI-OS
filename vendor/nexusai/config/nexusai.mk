# NANO AIOS Vendor Configuration

# Core AI Services
PRODUCT_PACKAGES += \
    AIManagerService \
    ModelManagerService \
    ContextService \
    PredictionService \
    PrivacyGuardian \
    AIAssistant

# AI Runtime
PRODUCT_PACKAGES += \
    libnexusai \
    libtensorflowlite \
    libonnxruntime

# System Apps
PRODUCT_PACKAGES += \
    AILauncher \
    NexusAssistant \
    AICamera \
    AITestApp \
    ModelTestApp \
    ContextTestApp \
    PredictionTestApp \
    PrivacyTestApp \
    AIAssistantTest

# Default Launcher
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nexusai.launcher=AILauncher

# AI Configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nexusai.enabled=true \
    ro.nexusai.version=1.0 \
    ro.nexusai.backend.npu=true \
    ro.nexusai.backend.nnapi=true \
    ro.nexusai.privacy.mode=strict

# Feature Flags
PRODUCT_PROPERTY_OVERRIDES += \
    persist.nexusai.prediction.enabled=true \
    persist.nexusai.context.enabled=true \
    persist.nexusai.assistant.enabled=true

# Performance Tuning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.nexusai.max_concurrent_inferences=4 \
    persist.nexusai.model_cache_size_mb=512 \
    persist.nexusai.inference_timeout_ms=5000