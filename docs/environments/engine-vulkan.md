# Introduction

## SDL2

SDL2 (Simple DirectMedia Layer 2) is a cross-platform multimedia library. It provides low-level access to:

- Window management
- Input handling (keyboard, mouse, gamepad)
- Audio playback
- 2D rendering

SDL2 handles platform-specific details, allowing you to write portable code. In this project, SDL2 creates the window and manages input while Vulkan handles rendering.

## Vulkan

Vulkan is a low-level graphics API and the successor to OpenGL. Key characteristics:

- Direct GPU control with minimal driver overhead
- Explicit memory and synchronization management
- Native multi-threading support
- Cross-platform (Windows, Linux, Android, macOS via MoltenVK)

Vulkan requires more setup code than OpenGL but offers better performance and predictability.

## Installation on Arch Linux

### SDL2

```bash
sudo pacman -S sdl2-compat
```

### Vulkan (NVIDIA)

```bash
# Core loader and NVIDIA driver
sudo pacman -S vulkan-icd-loader nvidia-utils

# Development tools
sudo pacman -S vulkan-headers vulkan-validation-layers shaderc vulkan-tools
```

### Verification

```bash
vkcube
```

A window with a spinning cube should appear. If it does, Vulkan is working correctly.

## Configuration

None required. The Vulkan ICD loader automatically detects installed drivers.
