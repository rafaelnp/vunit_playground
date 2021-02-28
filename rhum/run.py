
"""

multiple testcases testbench
------------------------

example of testbench with multiple testcases

"""



from pathlib import Path
from vunit import VUnit

VU = VUnit.from_argv()

TB_PATH = Path(__file__).parent / "*.vhd"

VU.add_library("rhum").add_source_files(TB_PATH)

VU.main()
