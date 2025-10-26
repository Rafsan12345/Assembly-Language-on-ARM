DE1-SoC ARMv7 Assembly Examples for CPUlator
--------------------------------------------
এই ফোল্ডারে বিভিন্ন হারে DE1-SoC (CPUlator: ARMv7) জন্য assembly উদাহরণ আছে।
প্রতিটি টেক্সট ফাইলকে CPUlator (https://cpulator.01xz.net/?sys=arm-de1soc) এ কপি-পেস্ট করে চালাতে পারবেন।

গুরুত্বপূর্ণ ঠিকানাগুলো (উপস্থিত ডকুমেন্টেশন অনুসারে):
 - RED LEDs (LEDR9..0):  0xFF200000. citeturn1search0turn1search2
 - Slider switches (SW9..0): 0xFF200040. citeturn1search1turn1search4
 - 7-segment HEX0..3: 0xFF200020, HEX4..5: 0xFF200030. citeturn1search7

ফাইলসমূহ:
1) led_blink.txt        - LED ব্লিঙ্ক (LEDR) কন্ট্রোল
2) read_switches.txt    - Slider switch পড়ে LED-এ দেখানো
3) uart_echo.txt        - UART echo (সিমুলেটেড, CPUlator terminal ব্যবহার)
4) hex_display.txt      - 7-segment HEX ডিসপ্লে নিয়ন্ত্রণ
5) timer_delay.txt      - হার্ডওয়্যার-ভিত্তিক (সিমুলেটেড) delay উদাহরণ
6) pushbutton_irq.txt   - পুশবাটন interrupt handling (CPUlator compatible stub)
7) spi_example.txt      - SPI প্রাথমিক রেজিস্টার access (দৃষ্টান্ত)
8) i2c_example.txt      - I2C প্রাথমিক (দৃষ্টান্ত) - বাস্তবে FPGA এ IP প্রয়োজন

নোট:
- CPUlator একটি শিক্ষামূলক সিস্টেম-সিমুলেটর; কিছু হার্ডওয়্যার IP/ড্রাইভার বাস্তবে ভিন্ন হতে পারে।
- প্রতিটি ফাইলে কোডের শীর্ষে ছোট নির্দেশিকা আছে (বাংলায়)।
- CPUlator-এ assembly পেস্ট করে "Assemble & Run" করুন।
