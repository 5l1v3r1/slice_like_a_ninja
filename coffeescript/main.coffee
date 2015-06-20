$ ->
	variableName = "var"
	currentString = "foo"
	targetString = "fo"
	currentStringHtml = "<h5>#{variableName} = " + '"'
	currentStringHtml += "#{currentString}"
	currentStringHtml += '"</h5>'
	$('#currentString').html currentStringHtml
	$('#targetString').html "<h5>#{targetString}</h5>"

	## FUNCTIONS ##
	
	# Handle user input to terminal
	inputCallback = (input, term) ->
		result = parseInput input
		if result == targetString
			term.clear()
			[currentString, targetString] = getNewStrings()
			currentStringHtml = "<h5>#{variableName} = " + '"'
			currentStringHtml += "#{currentString}"
			currentStringHtml += '"</h5>'
			$('#currentString').html currentStringHtml
			$('#targetString').html "<h5>#{targetString}</h5>"
			return
		else
			return result

	parseInput = (input) ->
		# Check for brackets
		inputLength = input.length
		if input[inputLength-1] != "]"
			return "Use a slice."
		variableLength = variableName.length
		if input[0..variableLength] != variableName + "["
			return "Use a slice."
		else
			sliceContents = input[variableLength+1..inputLength-2]
			# If you type my_string[] it is a syntax error technically
			if sliceContents == ""
				return "Use a slice"
			# If no colons, return a single character
			if not sliceContents.match ":"
				index = sliceContents
				return currentString[index] # TODO check for OOB
			else
				[firstIndex, secondIndex, stepSize] = sliceContents.split ":"
				if not firstIndex
					firstIndex = 0
				if not secondIndex
					secondIndex = currentString.length
				if not stepSize
					stepSize = 1
				console.log [firstIndex, secondIndex, stepSize]
				# TODO implement step
				result = currentString[firstIndex..secondIndex-1]
				if stepSize < 0
					result = result.split("").reverse().join("")
				stepSize = Math.abs stepSize
				if stepSize > 1
					numChars = Math.ceil(result.length / stepSize)
					fullResult = result
					result = ""
					for i in [0..numChars-1]
						alert i*stepSize
						result += fullResult[i*stepSize]
				return result

	getNewStrings = ->
		# TODO big time
		pairs = [
			["doggy", "dog"],
			["catheter", "cat"],
			["couscous", "us"],
			["spartacus", "part"],
			["robocop", "poco"],
			["pacer", "pcr"],
		]

		randomPair = pairs[Math.floor(Math.random() * pairs.length)]
		return randomPair

	# Show an example
	example = ->
		exampleHtml = "<h3>Example goes here</h3>"
		$('#exampleText').html exampleHtml
		$('#exampleScreen').foundation 'reveal', 'open'
		return

	# Create Terminal
	$('#terminalDiv').terminal(inputCallback,
		{ greetings: "",\
		  prompt: '>>> ',\
		  onBlur: false,\ # keeps terminal in focus
		  name: 'ninja_terminal',\
		  height: 300,
		  exceptionHandler: (error) -> console.log error,
		})

	# Help people out
	$("#exampleButton").click => example()
