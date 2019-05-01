project 21 - Browser
==

*error* :

Could not instantiate class named WKWebView because no class named WKWebView was found; the class needs to be defined in source code or linked in from a library (ensure the class is part of the correct target)



참고링크 : [WKWebView 오류](https://stackoverflow.com/questions/47142434/ios11-wkwebview-crash-due-to-nsinvalidunarchiveoperationexception)



error 원인 :
1. import WebKit을 하였으나, 해당 클래스를 찾지 못해서 발생하는 오류로, 실제로 WKWebView가 아닌 WebView를 생성하였었음.
2. Webkit.framework를 library에 추가하지 않았음.
