import torch
import triton
import triton.language as tl

print("================================")
print("Triton GPU Test")
print("================================")
print("Triton:", triton.__version__)
print("Torch:", torch.__version__)
print("HIP:", torch.version.hip)
print("GPU:", torch.cuda.get_device_name(0))
print("Arch:", torch.cuda.get_device_capability(0))

@triton.jit
def add_kernel(x, y, out, n, BLOCK: tl.constexpr):
    pid = tl.program_id(0)
    offs = pid * BLOCK + tl.arange(0, BLOCK)
    mask = offs < n
    xval = tl.load(x + offs, mask=mask)
    yval = tl.load(y + offs, mask=mask)
    tl.store(out + offs, xval + yval, mask=mask)

N = 1024
x = torch.ones(N, device="cuda")
y = torch.ones(N, device="cuda")
out = torch.empty_like(x)

add_kernel[((N + 127) // 128,)](x, y, out, N, BLOCK=128)
torch.cuda.synchronize()

print("RESULT:", out[0].item())
print("TRITON GPU KERNEL OK")
