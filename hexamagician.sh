
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
while read hexvaluetext
do
        # Do lots of stuff
        # Step 1, work the ZERO function
        # Will use a file called "/tmp/running_shellcode.txt"
        #
        running="/tmp/running_shellcode.txt"
        # Use the usexor variable to AND EAX (one way or another)
        if [ $usexor = "yes" ]
        then
                echo -n "\x31\x50" >> $running
        else
                echo -n "\x25\x4A\x4D\x4E\x55\x25\x35\x32\x31\x23\x54\x58" >> $running
        fi
        # XOR eax, eax added to "manually encoded shellcode"
        #
        # Our shellcode string from the parse file needs to be converted to a number
        # So bash can make the right decision based on math
        # Variable makeupper ensures the parsed line is in "HEX"
        # Variable makedecimal converts it to a number in decimal
        makeupper=$(echo $hexvaluetext | tr "[abcdef]" "[ABCDEF]")
        makedecimal=$(echo "obase=10; ibase=16; $makeupper" | bc)
        echo $makeupper >> $running
        # Now that it has been converted to decimal, I can calculate the new numbers and work on the triggers for 2/3 operands math
        # Reason
        # What is 100000000 (Hex) in decimal?
        # Answer : 4294967296
        # Everytime
        #
        # Now we need the math target
        # This is the number 4294967296 - $makedecimal.
        # This value and the eo(x) NOT ARRAY, encoding option
        # Will determine how many iterations we subtract to carve or value int EAX
        # And we need to use the array to avoid badcharacters
        # Range defs
        # halfrange = 7f7f7f7f is 2139062143 in decimal
        # If the intended value for EAX is greater than halfrange
        # Our subtrahends can be a single value less than halfrange for
        # eo1, eo2, eo4 ,e05 and e06
        # e03 requires a second subtrahend
        # quadrange = 7f7f7f is 8355711 in decimal
        # If intended value is less than quadrange
        # Then 1st subtrahend is halfrange. Second is 7fxyxyxy
        # 7f7f is 32639 in decimal

done < /tmp/shellcode_parse_1.txt
#
# New shellcode
echo "[-] Here is your shellcode, enjoy!"
cat $running
# Removing temporary files
#
/bin/rm /tmp/shellcode_parse* 2>/dev/null
/bin/rm $running 2>/dev/null
