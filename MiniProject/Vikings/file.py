import random

import vikingsClasses
from vikingsClasses import Viking
from vikingsClasses import War
from  vikingsClasses import Saxon

menu_1="""
    ------------------
    1-Añadir vikingo
    2-Añadir Sajón
    3-Iniciar Batalla
    4-Mostrar equipos
    5-Cerrar
    ------------------"""
elec_menu_1 =''
war = War()

while elec_menu_1 != '4' or elec_menu_1 !='cerrar':
    elec_menu_1 =str(input(menu_1 + '\n')).lower()

    if elec_menu_1 == '1':
        nombre_vikingo=''
        while nombre_vikingo == '':
            nombre_vikingo=str(input('Introduce el nombre del vikingo:'+ '\n')).title()

        viking1=Viking(nombre_vikingo,random.randint(50,100),random.randint(10,30))
        print(viking1.battleCry())
        war.addViking(viking1)

        print(f"Añadido vikingo {nombre_vikingo} al ejercito")

    elif elec_menu_1 =='2':
        war.addSaxon(Saxon(random.randint(50,100),random.randint(10,30)))
        print(f"Añadido un sajón aleatorio al ejército")

    elif elec_menu_1 == '3':
        while len(war.vikingArmy) > 0 and len(war.saxonArmy) > 0:
            who_attacks=random.randint(0,1)
            if who_attacks == 1:
                print(war.vikingAttack())
            else:
                print(war.saxonAttack())
        war.showStatus()
    else:
        print('Comando no encontrado prueba de nuevo')







