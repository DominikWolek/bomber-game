BOMBERMAN
---------
Projekt zosta³ wykonany w silniku Godot. Jest to silnik na licencji MIT do tworzenia gier
2D oraz 3D. Gry oparte na silniku mog¹ byæ tworzone w C++, my jednak zdecydowaliœmy siê
napisaæ grê w skryptowym jêzyku godota - GDScript. U¿ywa on sk³adni podobnej do Pythona.
Wiêkszoœæ z nas nie mia³a stycznoœci z tym jêzykiem oraz musia³a nauczyæ siê sposobu w
jaki silnik dzia³a od zera.
Godot wspiera platformy Windows oraz X11 (Linux).
Wszystkie tilesety oraz animacje s¹ oparte na licencji CC0. Dwie mapy zosta³y wykonane
przez Filipa Sowê. Wygl¹d bomby jest wzorowany na zagranicznym kanale YouTube'owym:
https://www.youtube.com/user/CommentisAnonymous. Uzyskaliœmy zgodê od twórcy na umieszczenie
tego wygl¹du w naszym projekcie.
---------
Wymagania systemowe: 
Windows 7 lub nowszy, macOS 10.10 lub nowszy, Linux (64-bit lub 32-bit x86)
Hardware wspomagaj¹cy OpenGL 3.3 Core Profile
---------
Godot opiera siê na idei scen oraz wêz³ów. Jest ona najlepiej opisana na stronie Godota
docs.godotengine.org. Oto krótki opis zarówno wêz³ów, jak i scen:

Wêz³y s¹ fundamentalnym elementem tworzenia gry. Wêze³ mo¿e wykonywaæ ró¿ne 
wyspecjalizowane funkcje. Jednak dany wêze³ zawsze posiada nastêpuj¹ce atrybuty:
- Ma nazwê.
- Posiada w³aœciwoœci które mo¿na edytowaæ.
- Mo¿e wywo³ywaæ zwrot co ka¿d¹ klatkê.
- Mo¿e byæ rozbudowywany (aby mieæ wiêcej funkcji).
- Mo¿e byæ dodany do innego wêz³a jako dziecko.
Wêz³y mog¹ mieæ inne wêz³y jako dzieci. Wêz³y u³o¿one w ten sposób staj¹ siê drzewem.

Scena sk³ada siê z grupy wêz³ów zorganizowanych hierarchicznie (w sposób drzewiasty). 
Co wiêcej, scena:
- zawsze ma jeden wêze³ g³ówny.
- mo¿e zostaæ zapisana na dysku i wczytana z powrotem.
- mo¿e byæ instancjonowana.
Uruchomienie gry oznacza uruchomienie sceny. Projekt mo¿e zawieraæ kilka scen, 
ale aby gra mog³a siê rozpocz¹æ, jedna z nich musi byæ wybrana jako scena g³ówna.

---------
Sposób kompilacji oraz instrukcja obs³ugi znajduj¹ siê w folderze "Dokumentacja projektu".
Ze wzglêdu na ciê¿ki wybór najwa¿niejszych metod i zmiennych z naszego projektu komentarze
dotycz¹ce funkcji/metod oraz zmiennych znajduj¹ siê bezpoœrednio w kodzie programu za³¹czonego
w folderze "Kod".
Krótkie przedstawienie najwa¿niejszych wêz³ów w naszym projekcie:
ConfigurationNode - odpowiedzialny za konfiguracje gry (mapa, dane graczy itp.). Zmiany dokonywane
przez gracza zapisywane s¹ w pliku config.cfg, oraz dane czytane s¹ z tego pliku. Wykorzystywany m.in
w scenach CharacterSettings, Sounds, MapScene.
Board - jest wêz³em okreœlanym jako TileMap. Wczytywane s¹ do niego odpowiednie tekstury. Board z za³o¿enia
jest rodzicem Playerów oraz Botów. Na tym wêŸle wykonywane s¹ operacje zwi¹zane m.in z podk³adaniem bomby.
Player - wêze³ bêd¹cy graczem. Obs³ugiwane s¹ w nim operacje zwi¹zane ze sterowaniem postaci¹ oraz akcje
takie jak utrata ¿ycia, zwiêkszenie ¿ycia gracza itp.
Bot - dziedziczy po Playerze. Do jego obs³ugi utworzyliœmy algorytm, który odpowiada za odpowiednie
podk³adanie bomb oraz odpowiednie poruszanie siê.

