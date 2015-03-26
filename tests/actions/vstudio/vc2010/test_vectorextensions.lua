---
-- tests/actions/vstudio/vc2010/test_vectorextensions.lua
-- Validate handling of vectorextensions() in VS 2010 C/C++ projects.
--
-- Created 26 Mar 2015 by Jason Perkins
-- Copyright (c) 2015 Jason Perkins and the Premake project
---

	local suite = test.declare("vs2010_vc_vectorextensions")
	local m = premake.vstudio.vc2010


	local sln, prj

	function suite.setup()
		_ACTION = "vs2010"
		sln, prj = test.createsolution()
	end

	local function prepare()
		local cfg = test.getconfig(prj, "Debug")
		m.enableEnhancedInstructionSet(cfg)
	end



	function suite.instructionSet_onNotSet()
		test.isemptycapture()
	end


	function suite.instructionSet_onSSE()
		vectorextensions "SSE"
		prepare()
		test.capture [[
<EnableEnhancedInstructionSet>StreamingSIMDExtensions</EnableEnhancedInstructionSet>
		]]
	end

	function suite.instructionSet_onSSE2()
		vectorextensions "SSE2"
		prepare()
		test.capture [[
<EnableEnhancedInstructionSet>StreamingSIMDExtensions2</EnableEnhancedInstructionSet>
		]]
	end

	function suite.instructionSet_onAVX()
		_ACTION = "vs2013"
		vectorextensions "AVX"
		prepare()
		test.capture [[
<EnableEnhancedInstructionSet>AdvancedVectorExtensions</EnableEnhancedInstructionSet>
		]]
	end

	function suite.instructionSet_onAVX_onVS2010()
		vectorextensions "AVX"
		prepare()
		test.isemptycapture()
	end

	function suite.instructionSet_onAVX2()
		_ACTION = "vs2013"
		vectorextensions "AVX2"
		prepare()
		test.capture [[
<EnableEnhancedInstructionSet>AdvancedVectorExtensions2</EnableEnhancedInstructionSet>
		]]
	end

	function suite.instructionSet_onAVX2_onVS2012()
		_ACTION = "vs2012"
		vectorextensions "AVX2"
		prepare()
		test.isemptycapture()
	end
