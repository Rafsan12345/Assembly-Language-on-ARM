extern void led_toggle_asm(void);   // declare assembly function

int main(void)
{

  led_toggle_asm();   // ✅ jump to assembly forever loop

  while (1)
  {
  }
}
