#!/bin/bash
#
# hexamagician, helps you with hexadecimal math
#
# Declare some arrays
#
all=(00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255)
lower=(00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127)
upper=(128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255)
alpha=(48 49 50 51 52 53 54 55 56 57 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122)
standard=(01 02 03 04 05 06 07 08 09 11 12 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255)
#
# Functions
function checksubone {
	# Convert subone to hexadecimal, as subonehex
	# We only come here if subtwo has a bad character in it.
	# Call the function increment subone. It has to be changed.
	incrementsubone
	subonehex=$(echo "obase=16; ibase=10; $subone" | bc)
	echo $subonehex > /tmp/subonehex.txt
	while read subonecheck
	do
		ins1active=$(echo ${activearray[@]} | grep -o $subonecheck | wc -w)
		if (( $subonecheck -gt 0 ))
		then
			# This is good, can move to the next byte
			# Reset the suboneincrementcounter
			suboneincrementcounter=0
		else
			#increment subone byte by one
			#establish a suboneincrementcounter
			if (( $subonedecrementcounter > 16 ))
			then	
				# bail, it is not working dude
				echo "[-] Tried to increment the byte up and down 16"
				echo "[-] It is not working!"
				exit
			else
				# Call the incrementsubonefunction
				incrementsubone
			fi
		fi
	done < /tmp/subonehex.txt
	# Subone has been changed
	subonehex=$(echo "obase=16; ibase=10; $subone" | bc)
	echo "[-] subtrahend one change to $subonehex"
	# Back to checking subtwo!	
}

function incrementsubone {
	if (( $incrementsubone -gt 15 ))
	then
		# We need to try to decrement subone. Check fails on increment.
		# Check if decrement subone has been done yet.
		# If it has, then subone can be calculated
		# Otherwise we need to toggle it back to default first
		if (( $subonedecrement -eq 0 ))
		then
			# Resetting subone
			subone=$(echo "obase=10; ibase=16; $subonehex" | bc)
		else
			echo "[-] boo " >/dev/null
		fi
		subonedecrement=$(( subonedecrement + 1 ))
		if (( $subtwoloop -eq 1 ))
		then
			# We are on that first byte. 
			# Subone will be decreased by 01000000
			subone=$(( subone - 16777216 ))
		elif (( $subtwoloop -eq 2 ))
		then
			# We are on the second byte
			# Subone will be decreased by 00010000
			subone=$(( subone - 65536 ))
		elif (( $subtwoloop -eq 3 ))
		then
			# We are on the third byte
			# Subone will be decreased by 00000100
			subone=$(( subone - 256 ))
		else
			# Forth byte
			#decrement subone by 00000001
			subone=$(( subone - 1 ))
		fi
	else
		# This increments subone based on how many bytes of subtwo have passed
		if (( $subtwoloop -eq 1 ))
		then
			# We are on that first byte. 
			# Subone will be increased by 01000000
			subone=$(( subone + 16777216 ))
		elif (( $subtwoloop -eq 2 ))
		then
			# We are on the second byte
			# Subone will be increased by 00010000
			subone=$(( subone + 65536 ))
		elif (( $subtwoloop -eq 3 ))
		then
			# We are on the third byte
			# Subone will be increased by 00000100
			subone=$((subone + 256 ))
		else
			# Forth byte
			#Increment subone by 00000001
			subone=$(( subone + 1))
		fi
	fi
}
# Script requires arguement, file of shellcode to manually encode
# Check if provided as argument
if [ ! -f $1 ]; then
        echo "[-] Cannot find your file!"
        echo "[-] Script needs a single argument of the full path to the shellcode file"
        echo "[-] Exiting"
        exit
fi
#
# Show shellcode file
#
echo -n "[-] Shellcode file is " && echo $1
#exit
#
# Script into and array options
#
clear
echo "[-] Welcome to the hexmagician!"
echo "[-] We have 5 declared arrays you can use "
echo "[-] 1: All 00-FF"
echo "[-] 2: Lower 00-7F"
echo "[-] 3: Upper 80-FF"
echo "[-] 4: Alpha 0-9, A-z in HEX/ASCII"
echo "[-] 5: Standard (omits the normal bad characters 00, 0a, 0d, 20)"
echo
#
# eo(x) is encoding option. The user will get to select 1-6
# Which is either a predefined 1-5 or option 6 will be custom
#
read -p "[-] Select 1-5 or enter 6 for custom set " eo1
#
# IV(x) is input valid for the while do done loop
#
iv1=invalid
while [ $iv1 = "invalid" ]
do
#
# Will use 3 if then fi loops
# if eo1 = 6, then user enters a custom list of bad characters
# if eo1 is 1 to 5, we choose one of the preformed options and go from there
# if eo1 is something else, we exit
#
        if [[ $eo1 -gt 0 && $eo1 -lt 6 ]]
        then
                iv1="valid"
        fi
        if [[ $eo1 -eq 6 ]]
        then
                echo
                echo "[-] Enter custom list here. Enter each hex bad char as two digits, separted by a space."
                echo "[-] Use CAPS. This will render as an array "
                echo "[-] Data validation is not in use, so if you screw it up, it is to your own peril"
                read -a customlist1
                for loop1 in "${customlist1[@]}"
                do
                        # Need to convert hex to decimal real quick
                        # Will use obase
                        purgeme=$(echo "obase=10; ibase=16; $loop1" | bc)
                        unset all[$purgeme]
                done
                # Test command to see if the all array has been modified.
                # Appears so, JMM 6/25/2019
                #declare -p all
                iv1="valid"
        fi
        if [[ $eo1 -gt 6 ]]
        then
                echo "[-] Invalid input, .. try again dude"
                # Putting exit, I do not feel like moving the while statement and reindexing everythin
                # Either use the script correctly or I am exiting
                exit
        fi
done
echo "[-] Input validated, proceeding .."
echo
sleep 2
#
# Data has been validated
# Now we have to make sure we are using the correct array
# For options 1 through 5, we will set the usexor variable
# Which measures whether the array has opcodes 1 through 5
#
if [[ $eo1 -eq 1 ]]
then
        activearray=( "${all[@]}" )
        # This is all characters allowed (rare)
        # We can use xor eax, eax
        usexor="yes"
# For options 2 through 4 lower, upper and alpha we do not have both 31 and C0
# usexor will be NO
elif [[ $eo1 -eq 2 ]]
then
        activearray=( "${lower[@]}" )
        usexor="no"
elif [[ $eo1 -eq 3 ]]
then
        usexor="no"
        activearray=( "${upper[@]}" )
elif [[ $eo1 -eq 4 ]]
then
        usexor="no"
        activearray=( "${alpha[@]}" )
elif [[ $eo1 -eq 5 ]]
then
        usexor="yes"
        activearray=( "${standard[@]}" )
elif [[ $eo1 -eq 6 ]]
then
        # Will check below before dealing with usexor
        #echo "[-] Array previously assigned ... "
        activearray=( "${all[@]}" )
else
        echo "[-] You can't see me!"
        echo "[-] You can't even get here"
fi
echo "[-] Active Array set!"
# test echo
#
echo "[-] Active Array follows for test purposes, comment out when testing is over"
echo "${activearray[@]}"
#
# We now use the eo<x> variable to define the following
# upperrange highest number we can subtract from EAX when it is set to 00000000
# lowerrange lowest number we can subtract from EAX after the upprange is subtracted
# midrange is the middle of upper and lower. Used to make the first subtrahend count
if [[ $eo1 -eq 3 ]]
then
        # Our usable characters are between 80 an FF
        # so our subtraction HAS to have (relatively) small values
        upperrange="4F4F4F4F"
        midrange="2F2F2F2F"
        lowerrange="00000001"
        # If upper shellcode is used (never seen) 81 will be the go to subtrahend one
        subonehex="81818181"
else
        # We can use more characters
        upperrange="5F5F5F5F"
        midrange="4F4F4F4F"
        lowerrange="00000001"
        # it is nearly inconcievable for 68 (push) to be a bad character in any shellcode
        subonehex="68686868"
fi
#
# Parse cpath ($1) into lines with 8 characters each
# Verified 6/25 jmm
# This nasty set of piped commands strips shellcode into lines of 8 hex digits
#echo -n "[-] Original shellcode = " && cat $1
cat $1 | tr -d '\n' | sed 's/\\x//g' | sed 's/\"//g' | sed 's/;//g' | sed 's/ //g' | fold -w 8 > /tmp/shellcode_parse_1.txt
#echo -n "[-] Converted as .. " && cat /tmp/shellcode_parse_1.txt
#exit
echo "[-] Shellcode converted to binary paste!"
#
# time to select a ZERO EAX strategy
# If we can use opcode 31 c0 for xor eax, eax
# We need to see if opcodes exist in the activearray (array)
# We can do this with nested if then (else) fi
if [[ $eo1 -eq 6 ]];
then
        # First set usexor to no. If it passes all tests, it gets changed to yes
        usexor="no"
        echo "[-] Parsing Array for opcodes 31 C0 (XOR EAX, EAX)"
        for opcodecheck in "${activearray[@]}"
        do
        if [ "$opcodecheck" == 49 ];
        then
                # The activearray variable contains 31. We can use that opcode. Need to check for C0
                # Need another for do done loop to check the bit set
                # This is the only way for eo6 (encoding option 6) to get usexor = yes
                echo "[-] 31 (HEX) found, checking for C0, For loop 2"
                for opcodecheck2 in "${activearray[@]}"
                do
                        if [[ "$opcodecheck2" == 192 ]];
                        then
                                # Both conditions are met. We can use xor eax, eax in our shellcode
                                usexor="yes"
                                echo "[-] We will be able to use xor eax, eax"
                                echo "[-] Isn't that wonderful!"
                        fi
                done
        fi
        done
else
        # usexor variable previously set
        echo "[-] YOU CAN'T SEE ME!" >/dev/null
fi
#
#echo "[-] Checked for XOR use complete "
#echo -n "[-] usexor = " && echo $usexor
echo
#
# Quick if then else fi to let user know approx shellcode size
if [ $usexor = "yes" ];
then
        echo "[-] We will be able to use XOR EAX, EAX, smaller shellcode!"
else
        echo "[-] We are using the AND method to zero out EAX. Larger shellcode"
fi
# Now to iterate through each line in the tmp file and convert our shellcode
cat /tmp/shellcode_parse_1.txt
echo "[-] Parsing shellcode file!"
while read hexvaluetext # Goal is to read 8 bytes of shellcode
do
        # Do lots of stuff
        # Step 1, work the ZERO function
        # Will use a file called "/tmp/running_shellcode.txt"
        #
        running="/tmp/running_shellcode.txt"
        #
        # Step 2, use the "usexor" variable to provide the code that will set EAX to 00000000
        #
        if [ $usexor = "yes" ]
        then
                echo -n "\x31\x50" >> $running
        else
                echo -n "\x25\x4A\x4D\x4E\x55\x25\x35\x32\x31\x23\x54\x58" >> $running
        fi
        # Step 3, Define variables. Since EAX is 00000000 we can begin carving the actual shellcode into a usable value
        # Bash prefers decimal, so we will make some pivots.
        # define zeroeax as the decimal equivalent of 100000000 (HEX)
        zeroeax=4294967296
        # Since this while read do done < file loop parses a row of shellcode
        # Define more variables to turn the opcodes (hex) into a number
        # Variable makeupper ensures the parsed line is in "HEX"
        # Variable makedecimal converts it to a number in decimal
        makeupper=$(echo $hexvaluetext | tr "[abcdef]" "[ABCDEF]")
        makedecimal=$(echo "obase=10; ibase=16; $makeupper" | bc)
        # echo "[-] Test echo $makeupper" >> $running
        # Now that it has been converted to decimal.
        # We can use the range variables we defined in the eo loops earlier in the script
        #
        useupper=$(echo "obase=10; ibase=16; $upperrange" | bc)
        uselower=$(echo "obase=10; ibase=16; $lowerrange" | bc)
        usemid=$(echo "obase=10; ibase=16; $midrange" | bc)
        # No This is defined: $makedecimal
        # And we need the decimal equivalent for subonehex (which will be subone)
        # Step 4 Convert subtrahend one to decimal
		subone=$(echo "obase=10; ibase=16; $subonehex" | bc)
        echo "[-] Admin first subtrahend is $subone (decimal) for $subonehex (hex)"
        #
        # Step 5 Calculate subtwo
        # Here need to verify zeroeax - subone - subtwo = hexvaluetext.
        # And subtwo cannot have a bad character
        # mathmatically through algebra
        # zeroeax - subone = makedecimal + subtwo
        # zeroeax - subone - makedecimal = subtwo
        # Admin ABOVE verified works hexcalculator.net
        # echo "[-] Admin calculate subtwo "
        # Use an IF THEN ELSE FI TO Align our numbers properly
        # Step 5a, calculate "intermediate eax". The value of the EAX register after subtracting subone, but before subtwo
        # intermediateeax = zeroeax - subone
        intermediateeax=$(( zeroeax - subone ))
        intermediatehex=$(echo "obase=16; ibase=10; $intermediateeax" | bc)
        # Step 5b, see if EAX is dropped too low. If it is, we reset subone
        if [[ $intermediateeax -lt $makedecimal ]]
        then
            echo "[-] $intermediatehex is less than $makeupper!"
            echo "[-] Reengineering subtraction from here "
            # This likely means our $makeupper value is > 69696969
            # Best bet from here is to "set" subone to relatively low and neutral value
            # Candidates include 10101010 15151515 19191919 21212121 23232323
            # check active array
            altsubone=(10101010 15151515 19191919 21212121 23232323)
            for altsubone in "${alt1list[@]}"
            do
                singlechars1=$(echo $altsubone | cut -c2)
                echo "[-] single character for altsubone is $singlechars1"
                ins1active=$(echo ${activearray[@]} | grep -o $singlechars1 | wc -w)
                if (( $ins1active -gt 0 ))
                then
					# The alternative to subone is in the array
                    echo "[-] subnow now $altsubone!"
                    subone=$altsubone
                else
                    "[-] Admin. $singchars1 is a bad character for the active array!"
					countalteax=$(( countalteax + 1 ))
					if (( $countalteax -gt 4 ))
					then
						echo "[-] cannot change eax to a working value"
						echo "[-] Try different encoding"
						echo "[-] Exiting"
						exit
					else
						echo "[-] $$altsubone failed!"
						sleep .25
					fi
				fi
            done
			
        else
			echo "[-] subone is not too large, normal flow"
            subtwo=$(( zeroeax - ( subone + makedecimal) ))
            subtwohex=$(echo "obase=16; ibase=10; $subtwo" | bc )
        fi
        #echo "[-] Admin subtwohex = $subtwohex"
        #echo "[-] Admin subtwo = $subtwo"
        #exit
        # Admin ABOVE verified works hexcalculator.net
        #
        # Must check subtwo for bad characters and range"
        # For the range, we can just convert 00FFFFFF to decimal
        # if it is below that, need to readjust
        # Then need to echo $subonehex into file, fold, parse and check if it is in the array
        # each line must be in the array, else, subone will be added to and the process will
        # rerun until it is correct
		# Step 6, convert subtwo to text, check for bad characters
        # echo $subtwo into a tmp file
        echo $subtwohex | fold -w2 > /tmp/subtwo.txt
        #echo "[-] Admin file review /tmp/subtwo.txt"
        #cat /tmp/subtwo.txt
        # Test counter
        # Step 7, run through the shellcode, four bytes at a time, seeing if subtwo will work.
		# This loop must be performed 4 times. It checks subtwo for badchars, two bytes at a time
		# It is mandatory
		#
        while read readsubtwo # This WDD loop reads individual bytes of subtwohex
        do
            #check if $readsubtwo is in the active array
            # in the active array=$(echo grep something | wc -w)
            # if inactivearray > 0 then
            # toggle keepworking
            # else
            # Lot of else. First we need to check the decimal value
            # if decimal < 00FFFFFF then we go into rework loop
            # else we can iterate subone by a 01010101 and check BOTH for bad char
            # until we get it right or subone > zeroeax which will trigger an abort
            # Since the array is in decimal, need to create a variable for a quick conversion
            readsubtwodec=$(echo "obase=10; ibase=16; $readsubtwo" | bc)
            inactive=$(echo ${activearray[@]} | grep -o $readsubtwodec | wc -w)
            echo "[-] Admin inactive = $inactive while reading $readsubtwo"
			#this is were the logic needs to be fixed.
			# Step 7a. Check subtwo two bytes at a time, for bad characters
            if (( $inactive > 0 ))
            then
				# The current character checked is not bad
                echo "[-] $readsubtwo passed check"
				counter=$(( counter +1 ))
				# Skip every check in the else. subone is good. subtwo is good.
			else
				# Rework this based one OneNote
				# Subone needs to be toggled, then checked for bad characters
				# We do this by calling the function checksubone.
				# Checksubone calls incrementsubone function, then verifies no bad chars.
				echo "[-] Running function checksubone / incrementsubone!"
				checksubone			
			fi
            # End of reading /tmp/subtwo.txt
            #counter=$(( counter + 1 ))
        done < /tmp/subtwo.txt
        #echo "[-] Admin we left the loop that parse 2 bytes per line!, counter = $counter"
        # If I am here, the I can write some frigging shellcode
        # START with zeroing the EAX register
        # then subtract
        echo -n "\x2D" >> $running
        #
        # Need to loop through subone
        # July 4, check this. subone is decimal, not hex. The below echo should fail
        # Validated subone valsubone = $(echo "obase=16; ibase=10; $subone | bc)
        valsubone=$(echo "obase=16; ibase=10; $subone" | bc)
        echo $valsubone | fold -w2 > /tmp/foldsubone.txt
        for subonebuild in $(cat /tmp/foldsubone.txt)
        do
                echo -n "\x" >> $running
                echo -n $subonebuild >> $running
        done
        #
        # Need to loop through subtwo
        echo -n "\x2D" >> $running
        for subtwobuild in $(cat /tmp/subtwo.txt)
        do
                echo -n "\x" >> $running
                echo -n $subtwobuild >> $running
        done
        # BUILDING THE MANUAL SHELLCODE
        # XOR eax, eax added to "manually encoded shellcode at the beginning of the loop
        # Which should represent a single line
done < /tmp/shellcode_parse_1.txt
#
# New shellcode
echo "[-] Here is your shellcode, enjoy!"
cat $running
# Removing temporary files
#
/bin/rm /tmp/shellcode_parse* 2>/dev/null
/bin/rm $running 2>/dev/null
/bin/rm /tmp/sub*
