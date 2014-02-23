Template.compositionInput.rendered = () ->
	$('textarea.gno-md-input').autosize()
	
Template.templateBar.helpers
	templateHandles: () ->
		$templates = $('.current-column').find('.gno-handle[data-c="te"]')
		console.log $templates
		handles = []
		$templates.each () ->
			$this = $(this)
			handles.push
				i: $this.attr 'data-i'
				c: $this.attr 'data-c'
				t: $this.text()
		
		return handles
			