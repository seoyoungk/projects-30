Project 23 - BirthDay
==

error :

 This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSContactsUsageDescription key with a string value explaining to the user how the app uses this data.


 참고링크 : [바로가기](https://github.com/dpa99c/cordova-diagnostic-plugin/issues/118)


 error 원인 :

 1. Info.plist 에 privacy- Contacts Usage Description과, NSContactsUsageDescription이 정의되어있지 않아서 발생한 에러.

  -> Info.plist에 해당사항을 추가해주면 해결된다.
