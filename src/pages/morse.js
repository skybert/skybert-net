
var morseCodeTable = new Object();

morseCodeTable["A"]= ".-";
morseCodeTable["B"]= "-...";
morseCodeTable["C"]= "-.-.";
morseCodeTable["D"]= "-..";
morseCodeTable["E"]= ".";
morseCodeTable["F"]= "..-.";
morseCodeTable["G"]= "--.";
morseCodeTable["H"]= "....";
morseCodeTable["I"]= "..";
morseCodeTable["J"]= ".---";
morseCodeTable["K"]= "-.-";
morseCodeTable["L"]= ".-..";
morseCodeTable["M"]= "--";
morseCodeTable["N"]= "-.";
morseCodeTable["O"]= "---";
morseCodeTable["P"]= ".--.";
morseCodeTable["Q"]= "--.-";
morseCodeTable["R"]= ".-.";
morseCodeTable["S"]= "...";
morseCodeTable["T"]= "-";
morseCodeTable["U"]= "..-";
morseCodeTable["V"]= "...-";
morseCodeTable["W"]= ".--";
morseCodeTable["X"]= "-..-";
morseCodeTable["Y"]= "-.--";
morseCodeTable["Z"]= "--..";
morseCodeTable["."]=".-.-.-";
morseCodeTable[","]="--..--";
morseCodeTable[":"]="---...";
morseCodeTable["?"]="..--..";
morseCodeTable["'"]=".----.";
morseCodeTable["-"]="-....-";
morseCodeTable["/"]="-..-.";
morseCodeTable["("]="-.--.-";
morseCodeTable["\""]=".-..-.";
morseCodeTable["@"]=".--.-.";
morseCodeTable["="]="-...-";
morseCodeTable["0"]="-----";
morseCodeTable["1"]=".----";
morseCodeTable["2"]="..---";
morseCodeTable["3"]="...--";
morseCodeTable["4"]="....-";
morseCodeTable["5"]=".....";
morseCodeTable["6"]="-....";
morseCodeTable["7"]="--...";
morseCodeTable["8"]="---..";
morseCodeTable["9"]="----.";
morseCodeTable[" "]=" ";

var latinCodeTable = new Object();
for (latinChar in morseCodeTable) {
    latinCodeTable[morseCodeTable[latinChar]] = latinChar;
}

function translateString(latingString, direction) {
    var result = "";
    if (direction == "latin2Morse") {
        for (var i = 0; i < latingString.length; i++) {
            result += morseCodeTable[latingString.charAt(i).toUpperCase()];
        }

    } else if (direction == "morse2Latin") {
        var morseLetter = "";
        for (var i = 0; i < latingString.length; i++) {
            if (latingString.charAt(i) == " ") {
                result += " ";
                result += latinCodeTable[morseLetter];
                morseLetter = "";
            } else {
                morseLetter += latingString.charAt(i);
            }
        }
    } else if (direction == "latin2DiDa") {
        for (var i = 0; i < latingString.length; i++) {
            var daDiChar = morseCodeTable[latingString.charAt(i).toUpperCase()];
            daDiChar = daDiChar.replace(/[-]/g, "dah-");
            daDiChar = daDiChar.replace(/[.]/g, "di-");
            daDiChar = daDiChar.replace(/[-]$/, "");
            daDiChar = daDiChar.replace(/di$/, "dit");
            if (daDiChar != " ") {
                daDiChar += "_";
            }
            result += daDiChar;
        }
    }

    return result;
}

function translateIt() {
    var inputField = document.getElementById("inputField");
    var directionFields = document.getElementsByName("directionField");
    var direction = "";

    for (var i = 0; i < directionFields.length; i++) {
        if (directionFields[i].checked) {
            direction = directionFields[i].value;
        }
    }

    var translatedString = translateString(inputField.value, direction);
    var outputField = document.getElementById("outputField");
    outputField.value = translatedString;
}
