// here be dragons - this is either pulled off the internet or coded in a similar style for consistency. Blech!

Elm.Native.TextMatch = {};
Elm.Native.TextMatch.make = function(localRuntime) {
  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.TextMatch = localRuntime.Native.TextMatch || {};

  if (localRuntime.Native.TextMatch.values) {
    return localRuntime.Native.TextMatch.values;
  }

  function phraseDistance(s1, s2) {
    if (s1 == s2) {
      return 0;
    }

    var s1_len = s1.length;
    var s2_len = s2.length;
    if (s1_len === 0) {
      return s2_len;
    }
    if (s2_len === 0) {
      return s1_len;
    }

    // BEGIN STATIC
    var split = false;
    try {
      split = !('0')[0];
    } catch (e) {
      split = true; // IE <= 7 does not support access by string index
    }
    // END STATIC
    if (split) {
      s1 = s1.split('');
      s2 = s2.split('');
    }

    var v0 = new Array(s1_len + 1);
    var v1 = new Array(s1_len + 1);

    var s1_idx = 0,
        s2_idx = 0,
        cost = 0;
    for (s1_idx = 0; s1_idx < s1_len + 1; s1_idx++) {
      v0[s1_idx] = s1_idx;
    }
    var char_s1 = '',
        char_s2 = '';
    for (s2_idx = 1; s2_idx <= s2_len; s2_idx++) {
      v1[0] = s2_idx;
      char_s2 = s2[s2_idx - 1];

      for (s1_idx = 0; s1_idx < s1_len; s1_idx++) {
        char_s1 = s1[s1_idx];
        cost = (char_s1 == char_s2) ? 0 : 1;
        var m_min = v0[s1_idx + 1] + 1;
        var b = v1[s1_idx] + 1;
        var c = v0[s1_idx] + cost;
        if (b < m_min) {
          m_min = b;
        }
        if (c < m_min) {
          m_min = c;
        }
        v1[s1_idx + 1] = m_min;
      }
      var v_tmp = v0;
      v0 = v1;
      v1 = v_tmp;
    }
    return v0[s1_len];
  }
  function wordsDistance(s1, s2) {
    var splitRegex = /\W/;
    var cleanup = function(a) { return a.filter(function(v) { return v.length > 0; }); };
    var w1 = cleanup(s1.split(splitRegex)),
        w2 = cleanup(s2.split(splitRegex));

    var w1_idx, w2_idx;
    var w1_len = w1.length,
        w2_len = w2.length;
    var wordBest, word1, word2;

    // Public Function valueWords#(ByRef S1$, ByRef S2$)
    //     Dim wordsS1$(), wordsS2$()
    //     wordsS1 = SplitMultiDelims(S1, " _-")
    //     wordsS2 = SplitMultiDelims(S2, " _-")
    //     Dim word1%, word2%, thisD#, wordbest#
    //     Dim wordsTotal#
    //     For word1 = LBound(wordsS1) To UBound(wordsS1)
    //         wordbest = Len(S2)
    //         For word2 = LBound(wordsS2) To UBound(wordsS2)
    //             thisD = LevenshteinDistance(wordsS1(word1), wordsS2(word2))
    //             If thisD < wordbest Then wordbest = thisD
    //             If thisD = 0 Then GoTo foundbest
    //         Next word2
    // foundbest:
    //         wordsTotal = wordsTotal + wordbest
    //     Next word1
    //     valueWords = wordsTotal
    // End Function
    var currDistance, wordsTotal = 0;
    for (w1_idx = 0; w1_idx < w1_len; w1_idx++) {
      word1 = w1[w1_idx];
      wordBest = s2.length;

      for (w2_idx = 0; w2_idx < w2_len; w2_idx++) {
        word2 = w2[w2_idx];
        currentD = phraseDistance(word1, word2);
        console.log("p1:" + word1 + "; p2:" + word2 + "; d:" + currentD);
        if (currentD < wordBest) {
          wordBest = currentD;
        }
        if (currentD === 0) {
          break;
        }
      }

      wordsTotal = wordsTotal + wordBest;
    }

    return wordsTotal;
  }

  return localRuntime.Native.TextMatch.values = {
    phraseDistance: F2(phraseDistance),
    wordsDistance: F2(wordsDistance),
  };
};
