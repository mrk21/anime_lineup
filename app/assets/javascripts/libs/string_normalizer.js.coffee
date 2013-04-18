class @StringNormalizer
  KATAKANA_CASE_TABLE =
    ァ: 'ア'
    ィ: 'イ'
    ゥ: 'ウ'
    ェ: 'エ'
    ォ: 'オ'
    ヵ: 'カ'
    ヶ: 'ケ'
    ッ: 'ツ'
    ャ: 'ヤ'
    ュ: 'ユ'
    ョ: 'ヨ'
    ヮ: 'ワ'
  
  KATAKANA_CASE_REGEXP = new RegExp "[#{_(KATAKANA_CASE_TABLE).keys().join('')}]", 'g'
  
  KATAKANA_ROMAN_TABLE =
    ア: 'a'
    イ: 'i'
    ウ: 'u'
    エ: 'e'
    オ: 'o'
    カ: 'ka'
    ガ: 'ga'
    キ: 'ki'
    ギ: 'gi'
    ク: 'ku'
    グ: 'gu'
    ケ: 'ke'
    ゲ: 'ge'
    コ: 'ko'
    ゴ: 'go'
    サ: 'sa'
    ザ: 'za'
    シ: 'shi'
    ジ: 'zi'
    ス: 'su'
    ズ: 'zu'
    セ: 'se'
    ゼ: 'ze'
    ソ: 'so'
    ゾ: 'zo'
    タ: 'ta'
    ダ: 'da'
    チ: 'ti'
    ヂ: 'di'
    ツ: 'tu'
    ヅ: 'du'
    テ: 'te'
    デ: 'de'
    ト: 'to'
    ド: 'do'
    ナ: 'na'
    ニ: 'ni'
    ヌ: 'nu'
    ネ: 'ne'
    ノ: 'no'
    ハ: 'ha'
    バ: 'ba'
    パ: 'pa'
    ヒ: 'hi'
    ビ: 'bi'
    ピ: 'pi'
    フ: 'fu'
    ブ: 'bu'
    プ: 'pu'
    ヘ: 'he'
    ベ: 'be'
    ペ: 'pe'
    ホ: 'ho'
    ボ: 'bo'
    ポ: 'po'
    マ: 'ma'
    ミ: 'mi'
    ム: 'mu'
    メ: 'me'
    モ: 'mo'
    ヤ: 'ya'
    ユ: 'yu'
    ヨ: 'yo'
    ラ: 'ra'
    リ: 'ri'
    ル: 'ru'
    レ: 're'
    ロ: 'ro'
    ワ: 'wa'
    ヰ: 'i'
    ヱ: 'e'
    ヲ: 'wo'
    ン: 'n'
    ヴ: 'vu'
  
  KATAKANA_ROMAN_REGEXP = new RegExp "[#{_(KATAKANA_ROMAN_TABLE).keys().join('')}]", 'g'
  
  @exec: (str) ->
    instance = new @(str)
    instance.exec()
  
  constructor: (@str = '') ->
  
  exec: ->
    @hiraganaToKatakana()
    @toKatakanaUpperCase()
    @katakanaToRoman()
    @zenkakuToHankaku()
    @str = @str.toUpperCase()
    @str
  
  hiraganaToKatakana: ->
    @str = @str.replace /[ぁ-ん]/g, (s) -> String.fromCharCode(s.charCodeAt(0) + 0x60)
  
  zenkakuToHankaku: ->
    @str = @str.replace /[！-～]/g, (s) -> String.fromCharCode(s.charCodeAt(0) - 0xFEE0)
  
  toKatakanaUpperCase: ->
    @str = @str.replace KATAKANA_CASE_REGEXP, (s) -> KATAKANA_CASE_TABLE[s]
  
  katakanaToRoman: ->
    @str = @str.replace KATAKANA_ROMAN_REGEXP, (s) -> KATAKANA_ROMAN_TABLE[s]
