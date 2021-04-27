#! /usr/bin/awk -f

# This scripts alphabetizes both the whoole file as well as sections between the newlines in a file
# used to make snapcat ldap extract workable with diff
# usage   ./awksript inputFile > outputFile.txt

BEGIN {
  c_empty_line=1;	# Will be key for locations of empty lines
  c_line=1;			# Line numbers inside a section
  c_section=1;		# Section numbers (every ldap entry)
}


{
  # SAVE LINES FILE TO AN ARRAY
  text_lines[c_section][c_line] = $0
  c_line = c_line + 1;

  # LOCATION OF EMPTY LINES
  if ($0 == "")
  {
  c_section=c_section+1;
  c_line=1;
  }
}


END {

  # Remove empty lines from all arrays and subarrays
  for (i in text_lines)
    for (j in text_lines[i])
	  if (text_lines[i][j] == "")
	    delete text_lines[i][j]

  # Sort Outer array alphabetically - sections themselves
  asort(text_lines)
  
  # Sort Inner arrays alphabetically - lines within a section.
  for (i in text_lines)
    asort(text_lines[i])

  # Print alphabetically ordered data
  for (i in text_lines)
  {
    for (j in text_lines[i])
	{
	  print text_lines[i][j]
    }
  print ""				# Add empty line after each section
  }
  
}