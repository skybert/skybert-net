title: Morse code translator
date: 2014-12-01

<script type="text/javascript" src="morse.js"></script>
<form action="">
  <div>
    Latin2Morse:
    <input id="directionField"
           name="directionField"
           type="radio"
           value="latin2Morse"
           onclick="translateIt()"
           checked />
    <br/>
    Morse2Latin:
    <input id="directionField"
           name="directionField"
           type="radio"
           value="morse2Latin"
           onclick="translateIt()" />
    <br/>
    Latin2DiDa:
    <input id="directionField"
           name="directionField"
           type="radio"
           value="latin2DiDa"
           onclick="translateIt()" />
  </div>
  <div>
    <textarea id="inputField" onkeyup="translateIt()"
              cols="60" rows="2"
              autofocus>
    </textarea>
  </div>
  <div>
    <textarea id="outputField" cols="60" rows="10">

    </textarea>
  </div>
</form>
