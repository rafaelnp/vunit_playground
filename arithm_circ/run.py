
"""

multiple testcases testbench
------------------------

example of testbench with multiple testcases

"""



from pathlib import Path
from vunit import VUnit

VU = VUnit.from_argv()

SRC_PATH = Path(__file__).parent / "src" / "*.vhd"
TB_PATH  = Path(__file__).parent / "sim" / "*.vhd"

VU.add_osvvm()
VU.add_library("mylib").add_source_files([SRC_PATH, TB_PATH])

VU.main()
