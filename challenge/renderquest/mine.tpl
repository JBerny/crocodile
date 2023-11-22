{{ $A := "assigns variables" }}{{ $A }}.

{{ if (file.Exists "/flag.txt") }}yes{{else}}no{{end}}
