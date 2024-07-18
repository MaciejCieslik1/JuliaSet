#include <allegro5/allegro5.h>
#include <allegro5/allegro_font.h>
#include "SetJulia.h"


void showPixels(uint8_t *pixels, int width, int height) 
{
    for (int row = 0; row < height; row++) 
    {
        for (int column = 0; column < width; column++) 
        {
            int pixelIndex = 3 * (row * width + column);
            al_draw_pixel(column, row, al_map_rgb( pixels[pixelIndex], pixels[pixelIndex + 1], pixels[pixelIndex + 2]));
        }
    }
}


int main() 
{
    int WIDTH = 1024;
    int HEIGHT = 1024;
    al_init();
    al_install_keyboard();
    ALLEGRO_TIMER *timer = al_create_timer(1.0 / 25.0);
    ALLEGRO_EVENT_QUEUE *queue = al_create_event_queue();
    ALLEGRO_DISPLAY *display = al_create_display(WIDTH, HEIGHT);
    ALLEGRO_FONT *font = al_create_builtin_font();
    al_register_event_source(queue, al_get_keyboard_event_source());
    al_register_event_source(queue, al_get_timer_event_source(timer));
    bool drawAgain = true;
    ALLEGRO_EVENT event;
    uint8_t *pixels = malloc(WIDTH * HEIGHT * 3);
    double radius = 2.0;
    double cReal = -0.7;
    double cImaginary = 0.2;
    double offsetReal = (double)WIDTH / 2;
    double offsetImaginary = (double)HEIGHT / 2;
    double zoom = 1.0;
    double deltaOffset = 10.0;
    double deltaC = 0.05;
    double deltaZoom = 0.05;
    setJulia(pixels, WIDTH, HEIGHT, radius, cReal, cImaginary, offsetReal, offsetImaginary, zoom);
    showPixels(pixels, WIDTH, HEIGHT);
    al_start_timer(timer);
    while (true) 
    {
        al_wait_for_event(queue, &event);
        if (event.type == ALLEGRO_EVENT_KEY_CHAR) 
        {
            if (event.keyboard.keycode == ALLEGRO_KEY_LEFT) 
            {
                cReal -= deltaC;
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_RIGHT) 
            {
                cReal += deltaC;
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_UP) 
            {
                cImaginary += deltaC;
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_DOWN) 
            {
                cImaginary -= deltaC;
            }
            if (event.keyboard.keycode == ALLEGRO_KEY_W) 
            {
                offsetImaginary -= deltaOffset;
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_A) 
            {
                offsetReal -= deltaOffset;
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_S) 
            {
                offsetImaginary += deltaOffset;
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_D) 
            {
                offsetReal += deltaOffset;
            }
            if (event.keyboard.keycode == ALLEGRO_KEY_MINUS) 
            {
                if (zoom - deltaZoom > 0) {zoom = zoom - deltaZoom;}
                else {zoom = 0;}
            } 
            else if (event.keyboard.keycode == ALLEGRO_KEY_EQUALS) 
            {
                zoom += deltaZoom;
            }

            if (event.keyboard.keycode == ALLEGRO_KEY_ESCAPE) 
            {
                break;
            }
            drawAgain = true;
        } 
        else if (event.type == ALLEGRO_EVENT_DISPLAY_CLOSE) 
        {
            break;
        }

        if (al_is_event_queue_empty(queue) && drawAgain) 
        {
            setJulia(pixels, WIDTH, HEIGHT, radius, cReal, cImaginary, offsetReal, offsetImaginary, zoom);
            showPixels(pixels, WIDTH, HEIGHT);
            al_flip_display();
            drawAgain = false;
        }
    }
    al_destroy_font(font);
    al_destroy_display(display);
    al_destroy_timer(timer);
    al_destroy_event_queue(queue);
    free(pixels);
    return 0;
}