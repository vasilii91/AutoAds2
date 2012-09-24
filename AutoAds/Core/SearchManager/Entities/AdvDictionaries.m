//
//  AdvDictionaries.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvDictionaries.h"

@implementation AdvDictionaries


#pragma mark - Cities

+ (NSDictionary *)Cities2
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100101u0000010000000" forKey:@"Екатеринбург"];
    [dictionary setValue:@"10010220000090000000" forKey:@"Магнитогорск"];
    [dictionary setValue:@"10010250000000000000" forKey:@"Москва"];
    [dictionary setValue:@"10010020000040000000" forKey:@"Октябрьский"];
    [dictionary setValue:@"10010020000050000000" forKey:@"Салават"];
    [dictionary setValue:@"10010020160010000000" forKey:@"Стерлитакам"];
    [dictionary setValue:@"10010020180010000000" forKey:@"Туймазы"];
    [dictionary setValue:@"10010020010010000000" forKey:@"Уфа"];
    [dictionary setValue:@"10010220000010000000" forKey:@"Челябинск"];
    
    
    return dictionary;
}

+ (NSDictionary *)Cities16
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100100g0080010000000" forKey:@"Альметьевск"];
    [dictionary setValue:@"00100100g00e0010000000" forKey:@"Бугульма"];
    [dictionary setValue:@"00100100g00j0010000000" forKey:@"Елабуга"];
    [dictionary setValue:@"00100100g00l0010000000" forKey:@"Зеленодольск"];
    [dictionary setValue:@"00100100g0000010000000" forKey:@"Казань"];
    [dictionary setValue:@"10010250000000000000" forKey:@"Москва"];
    [dictionary setValue:@"00100100g0140010000000" forKey:@"Набережные Челны"];
    [dictionary setValue:@"00100100g00v0010000000" forKey:@"Нижнекамск"];
    [dictionary setValue:@"00100100g00v0010000000" forKey:@"Челябинск"];
    
    return dictionary;
}

+ (NSDictionary *)Cities29
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100100t0000010000000" forKey:@"Архангельск"];
    [dictionary setValue:@"00100100t0020010000000" forKey:@"Вельск"];
    [dictionary setValue:@"00100100t0000050000000" forKey:@"Коряжма"];
    [dictionary setValue:@"00100100t0080010000000" forKey:@"Котлас"];
    [dictionary setValue:@"00100100t0000020000000" forKey:@"Мирный"];
    [dictionary setValue:@"00100100t0000030000000" forKey:@"Новодвинск"];
    [dictionary setValue:@"00100100t00e0010000000" forKey:@"Онега"];
    [dictionary setValue:@"00100100t00g0000010000" forKey:@"Плесецк"];
    [dictionary setValue:@"00100100t0000040000000" forKey:@"Северодвинск"];
    
    return dictionary;
}

+ (NSDictionary *)Cities34
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100100y0000010000000" forKey:@"Волгоград"];
    [dictionary setValue:@"00100100y0000020000000" forKey:@"Волжский"];
    [dictionary setValue:@"00100100y0080010000000" forKey:@"Жирновск"];
    [dictionary setValue:@"00100100y00b0010000000" forKey:@"Камышин"];
    [dictionary setValue:@"00100100n0000010000000" forKey:@"Краснодар"];
    [dictionary setValue:@"00100100y00i0010000000" forKey:@"Михайловка"];
    [dictionary setValue:@"10010250000000000000" forKey:@"Москва"];
    [dictionary setValue:@"00100100y00v0010000000" forKey:@"Урюпинск"];
    [dictionary setValue:@"00100100y00w0010000000" forKey:@"Фролово"];
    
    return dictionary;
}

+ (NSDictionary *)Cities59
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100101n0000020000000" forKey:@"Березники"];
    [dictionary setValue:@"00100101u0000010000000" forKey:@"Екатеринбург"];
    [dictionary setValue:@"00100101n0000090000000" forKey:@"Кунгур"];
    [dictionary setValue:@"00100101n00000a0000000" forKey:@"Лысьва"];
    [dictionary setValue:@"10010250000000000000" forKey:@"Москва"];
    [dictionary setValue:@"00100101n0000010000000" forKey:@"Пермь"];
    [dictionary setValue:@"00100101n00000b0000000" forKey:@"Соликамск"];
    [dictionary setValue:@"00100101n00000c0000000" forKey:@"Чайковский"];
    [dictionary setValue:@"10010220000010000000" forKey:@"Челябинск"];
    
    return dictionary;
}

+ (NSDictionary *)Cities61
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100101p0020010000000" forKey:@"Азов"];
    [dictionary setValue:@"00100101p0030010000000" forKey:@"Аксай"];
    [dictionary setValue:@"00100101p0000030000000" forKey:@"Батайск"];
    [dictionary setValue:@"00100101p0000040000000" forKey:@"Волгодонск"];
    [dictionary setValue:@"00100101p0000080000000" forKey:@"Каменск-Шахтинский"];
    [dictionary setValue:@"00100101p0000090000000" forKey:@"Новочеркасск"];
    [dictionary setValue:@"00100101p0000010000000" forKey:@"Ростов-на-Дону"];
    [dictionary setValue:@"00100101p00000b0000000" forKey:@"Таганрог"];
    [dictionary setValue:@"00100101p00000c0000000" forKey:@"Шахты"];
    
    return dictionary;
}

+ (NSDictionary *)Cities63
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100101r00000a0000000" forKey:@"Кинель"];
    [dictionary setValue:@"00100101r00h0010000000" forKey:@"Нефтегорск"];
    [dictionary setValue:@"00100101r0000030000000" forKey:@"Новокуйбышевск"];
    [dictionary setValue:@"00100101r0000050000000" forKey:@"Отрадный"];
    [dictionary setValue:@"00100101r0000010000000" forKey:@"Самара"];
    [dictionary setValue:@"00100101r0000080000000" forKey:@"Сызрань"];
    [dictionary setValue:@"00100101r0000070000000" forKey:@"Тольятти"];
    [dictionary setValue:@"00100101r0000060000000" forKey:@"Чапаевск"];
    [dictionary setValue:@"10010220000010000000" forKey:@"Челябинск"];
    
    return dictionary;
}

+ (NSDictionary *)Cities72
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"00100101u0000010000000" forKey:@"Екатеринбург"];
    [dictionary setValue:@"10010200090010000000" forKey:@"Заводоуковск"];
    [dictionary setValue:@"00100102000b0010000000" forKey:@"Ишим"];
    [dictionary setValue:@"10010190000010000000" forKey:@"Курган"];
    [dictionary setValue:@"10010250000000000000" forKey:@"Москва"];
    [dictionary setValue:@"10010200000020000000" forKey:@"Тобольск"];
    [dictionary setValue:@"10010200000010000000" forKey:@"Тюмень"];
    [dictionary setValue:@"10010220000010000000" forKey:@"Челябинск"];
    [dictionary setValue:@"a00100102000l0010000000" forKey:@"Ялуторовск"];
    
    return dictionary;
}

+ (NSDictionary *)Cities74
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"a00100101u0000010000000" forKey:@"Екатеринбург"];
    [dictionary setValue:@"a10010220000040000000" forKey:@"Златоуст"];
    [dictionary setValue:@"a10010220000060000000" forKey:@"Копейск"];
    [dictionary setValue:@"a10010220000090000000" forKey:@"Магнитогорск"];
    [dictionary setValue:@"a00100102200000a0000000" forKey:@"Миасс"];
    [dictionary setValue:@"a00100102200000b0000000" forKey:@"Озерск"];
    [dictionary setValue:@"a10010220130010000000" forKey:@"Троицк"];
    [dictionary setValue:@"a10010220000010000000" forKey:@"Челябинск"];
    [dictionary setValue:@"a00100102200000g0000000" forKey:@"Южноуральск"];
    
    return dictionary;
}

+ (NSDictionary *)Cities76
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"a10010240050010000000" forKey:@"Гаврилов-Ям"];
    [dictionary setValue:@"a10010250000000000000" forKey:@"Москва"];
    [dictionary setValue:@"a10010240000020000000" forKey:@"Переславль-Залесский"];
    [dictionary setValue:@"a00100101p0000010000000" forKey:@"Ростов"];
    [dictionary setValue:@"a00100102400f0010000000" forKey:@"Рыбинск"];
    [dictionary setValue:@"a00100102400g0010000000" forKey:@"Тутаев"];
    [dictionary setValue:@"a00100102400h0010000000" forKey:@"Углич"];
    [dictionary setValue:@"a10010220000010000000" forKey:@"Челябинск"];
    [dictionary setValue:@"a10010240000010000000" forKey:@"Ярославль"];
    
    return dictionary;
}


#pragma mark - Colors

+ (NSDictionary *)WheelColors
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"11" forKey:@"Белый"];
    [dictionary setValue:@"26" forKey:@"Желтый"];
    [dictionary setValue:@"31" forKey:@"Золотистый"];
    [dictionary setValue:@"35" forKey:@"Коричневый"];
    [dictionary setValue:@"40" forKey:@"Красный"];
    [dictionary setValue:@"61" forKey:@"Оранжевый"];
    [dictionary setValue:@"204" forKey:@"Серебристый"];
    [dictionary setValue:@"116" forKey:@"Синий"];
    [dictionary setValue:@"114" forKey:@"Хром"];
    [dictionary setValue:@"172" forKey:@"Черный"];
    
    return dictionary;
}

+ (NSDictionary *)VehicleColors
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"193" forKey:@"Авантюрин"];
    [dictionary setValue:@"4" forKey:@"Адриатик"];
    [dictionary setValue:@"5" forKey:@"Аквамарин"];
    [dictionary setValue:@"195" forKey:@"Амулет"];
    [dictionary setValue:@"272" forKey:@"Амулет люкс"];
    [dictionary setValue:@"216" forKey:@"Антилопа"];
    [dictionary setValue:@"260" forKey:@"Атлантика"];
    [dictionary setValue:@"177" forKey:@"Афалина"];
    [dictionary setValue:@"6" forKey:@"Баклажан"];
    [dictionary setValue:@"183" forKey:@"Балтика"];
    [dictionary setValue:@"7" forKey:@"Бежевый"];
    [dictionary setValue:@"9" forKey:@"Белая лилия"];
    [dictionary setValue:@"10" forKey:@"Белая ночь"];
    [dictionary setValue:@"191" forKey:@"Бело-серый"];
    [dictionary setValue:@"11" forKey:@"Белый"];
    [dictionary setValue:@"242" forKey:@"Белый леденец"];
    [dictionary setValue:@"188" forKey:@"Белый соболь"];
    [dictionary setValue:@"13" forKey:@"Бирюза"];
    [dictionary setValue:@"15" forKey:@"Бордовый"];
    [dictionary setValue:@"205" forKey:@"Бордовый перламутр"];
    [dictionary setValue:@"189" forKey:@"Бриз"];
    [dictionary setValue:@"17" forKey:@"Валентина"];
    [dictionary setValue:@"214" forKey:@"Васильковый"];
    [dictionary setValue:@"176" forKey:@"Виктория"];
    [dictionary setValue:@"232" forKey:@"Вишневый перламутр"];
    [dictionary setValue:@"256" forKey:@"Вишневый сад"];
    [dictionary setValue:@"18" forKey:@"Вишня"];
    [dictionary setValue:@"21" forKey:@"Голубой"];
    [dictionary setValue:@"190" forKey:@"Гранат"];
    [dictionary setValue:@"301" forKey:@"Гранат-тюнинг"];
    [dictionary setValue:@"23" forKey:@"Гранатовый"];
    [dictionary setValue:@"265" forKey:@"Дипломат"];
    [dictionary setValue:@"262" forKey:@"Желто-зеленый"];
    [dictionary setValue:@"26" forKey:@"Желтый"];
    [dictionary setValue:@"28" forKey:@"Жемчуг"];
    [dictionary setValue:@"234" forKey:@"Зеленая яшма"];
    [dictionary setValue:@"29" forKey:@"Зеленый"];
    [dictionary setValue:@"199" forKey:@"Зеленый сад"];
    [dictionary setValue:@"219" forKey:@"Зеркально-серебристый"];
    [dictionary setValue:@"263" forKey:@"Золотисто-желтый"];
    [dictionary setValue:@"31" forKey:@"Золотой"];
    [dictionary setValue:@"293" forKey:@"Золотой лист"];
    [dictionary setValue:@"203" forKey:@"Ива"];
    [dictionary setValue:@"211" forKey:@"Ива серебристая"];
    [dictionary setValue:@"175" forKey:@"Игуана"];
    [dictionary setValue:@"33" forKey:@"Изумруд"];
    [dictionary setValue:@"34" forKey:@"Ирис"];
    [dictionary setValue:@"220" forKey:@"Испанский красный"];
    [dictionary setValue:@"217" forKey:@"Кармен"];
    [dictionary setValue:@"285" forKey:@"Кварц"];
    [dictionary setValue:@"181" forKey:@"Коралл"];
    [dictionary setValue:@"35" forKey:@"Коричневый"];
    [dictionary setValue:@"37" forKey:@"Коррида"];
    [dictionary setValue:@"245" forKey:@"Корсика"];
    [dictionary setValue:@"40" forKey:@"Красный"];
    [dictionary setValue:@"42" forKey:@"Кремовый"];
    [dictionary setValue:@"212" forKey:@"Лагуна"];
    [dictionary setValue:@"210" forKey:@"Магия"];
    [dictionary setValue:@"246" forKey:@"Майя"];
    [dictionary setValue:@"46" forKey:@"Малиновый"];
    [dictionary setValue:@"48" forKey:@"Медео"];
    [dictionary setValue:@"49" forKey:@"Металлик"];
    [dictionary setValue:@"50" forKey:@"Миндаль"];
    [dictionary setValue:@"187" forKey:@"Мираж"];
    [dictionary setValue:@"255" forKey:@"Млечный путь"];
    [dictionary setValue:@"276" forKey:@"Млечный путь люкс"];
    [dictionary setValue:@"51" forKey:@"Мокрый асфальт"];
    [dictionary setValue:@"54" forKey:@"Морская волна"];
    [dictionary setValue:@"248" forKey:@"Мулен Руж"];
    [dictionary setValue:@"56" forKey:@"Мурена"];
    [dictionary setValue:@"58" forKey:@"Нептун"];
    [dictionary setValue:@"281" forKey:@"Нефертити"];
    [dictionary setValue:@"280" forKey:@"Нефертити люкс"];
    [dictionary setValue:@"200" forKey:@"Ниагара"];
    [dictionary setValue:@"275" forKey:@"Ниагара люкс"];
    [dictionary setValue:@"184" forKey:@"Океан"];
    [dictionary setValue:@"259" forKey:@"Оливин"];
    [dictionary setValue:@"59" forKey:@"Оливковый"];
    [dictionary setValue:@"60" forKey:@"Опал"];
    [dictionary setValue:@"274" forKey:@"Опал люкс"];
    [dictionary setValue:@"61" forKey:@"Оранж"];
    [dictionary setValue:@"258" forKey:@"Осока"];
    [dictionary setValue:@"63" forKey:@"Охра"];
    [dictionary setValue:@"65" forKey:@"Папирус"];
    [dictionary setValue:@"273" forKey:@"Папирус люкс"];
    [dictionary setValue:@"213" forKey:@"Перламутрово-бежевый"];
    [dictionary setValue:@"66" forKey:@"Песочный"];
    [dictionary setValue:@"68" forKey:@"Пицунда"];
    [dictionary setValue:@"69" forKey:@"Приз"];
    [dictionary setValue:@"185" forKey:@"Приз-инж"];
    [dictionary setValue:@"70" forKey:@"Примула"];
    [dictionary setValue:@"71" forKey:@"Рапсодия"];
    [dictionary setValue:@"277" forKey:@"Рапсодия люкс"];
    [dictionary setValue:@"72" forKey:@"Розовый"];
    [dictionary setValue:@"74" forKey:@"Рубиновый"];
    [dictionary setValue:@"76" forKey:@"Салатовый"];
    [dictionary setValue:@"241" forKey:@"Сандал"];
    [dictionary setValue:@"78" forKey:@"Сафари"];
    [dictionary setValue:@"80" forKey:@"Светло-бежевый"];
    [dictionary setValue:@"85" forKey:@"Светло-голубой"];
    [dictionary setValue:@"87" forKey:@"Светло-гранатовый"];
    [dictionary setValue:@"88" forKey:@"Светло-желтый"];
    [dictionary setValue:@"90" forKey:@"Светло-зеленый"];
    [dictionary setValue:@"92" forKey:@"Светло-коричневый"];
    [dictionary setValue:@"94" forKey:@"Светло-красный"];
    [dictionary setValue:@"97" forKey:@"Светло-песочный"];
    [dictionary setValue:@"102" forKey:@"Светло-песочный"];
    [dictionary setValue:@"104" forKey:@"Светло-серый"];
    [dictionary setValue:@"105" forKey:@"Светло-синий"];
    [dictionary setValue:@"107" forKey:@"Светло-сиреневый"];
    [dictionary setValue:@"109" forKey:@"Светло-фиолетовый"];
    [dictionary setValue:@"194" forKey:@"Серебристая ива"];
    [dictionary setValue:@"218" forKey:@"Серебристо-голубой"];
    [dictionary setValue:@"204" forKey:@"Серебристый"];
    [dictionary setValue:@"224" forKey:@"Серебристый ярко-зеленый"];
    [dictionary setValue:@"112" forKey:@"Серебро"];
    [dictionary setValue:@"257" forKey:@"Серо-белый"];
    [dictionary setValue:@"254" forKey:@"Серо-голубой"];
    [dictionary setValue:@"244" forKey:@"Серо-зеленый"];
    [dictionary setValue:@"238" forKey:@"Серо-синий"];
    [dictionary setValue:@"225" forKey:@"Серо-стальной"];
    [dictionary setValue:@"114" forKey:@"Серый"];
    [dictionary setValue:@"227" forKey:@"Сине-зеленый"];
    [dictionary setValue:@"116" forKey:@"Синий"];
    [dictionary setValue:@"230" forKey:@"Синий деним"];
    [dictionary setValue:@"229" forKey:@"Синий кристал"];
    [dictionary setValue:@"249" forKey:@"Синий океан"];
    [dictionary setValue:@"223" forKey:@"Синяя королева"];
    [dictionary setValue:@"118" forKey:@"Синяя ночь"];
    [dictionary setValue:@"119" forKey:@"Сиреневый"];
    [dictionary setValue:@"180" forKey:@"Сливочно-белый"];
    [dictionary setValue:@"186" forKey:@"Снежная королева"];
    [dictionary setValue:@"252" forKey:@"Снежно-белый"];
    [dictionary setValue:@"222" forKey:@"Табак"];
    [dictionary setValue:@"126" forKey:@"Темно-бордовый"];
    [dictionary setValue:@"128" forKey:@"Темно-вишня"];
    [dictionary setValue:@"130" forKey:@"Темно-голубой"];
    [dictionary setValue:@"134" forKey:@"Темно-желтый"];
    [dictionary setValue:@"135" forKey:@"Темно-зеленый"];
    [dictionary setValue:@"179" forKey:@"Темно-зеленый перламутр"];
    [dictionary setValue:@"137" forKey:@"Темно-золотой"];
    [dictionary setValue:@"139" forKey:@"Темно-коричневый"];
    [dictionary setValue:@"141" forKey:@"Темно-кофейный"];
    [dictionary setValue:@"142" forKey:@"Темно-красный"];
    [dictionary setValue:@"144" forKey:@"Темно-лиловый"];
    [dictionary setValue:@"145" forKey:@"Темно-малиновый"];
    [dictionary setValue:@"146" forKey:@"Темно-оранжевый"];
    [dictionary setValue:@"148" forKey:@"Темно-песочный"];
    [dictionary setValue:@"150" forKey:@"Темно-розовый"];
    [dictionary setValue:@"152" forKey:@"Темно-рубиновый"];
    [dictionary setValue:@"154" forKey:@"Темно-серебро"];
    [dictionary setValue:@"156" forKey:@"Темно-серый"];
    [dictionary setValue:@"231" forKey:@"Темно-серый перламутр"];
    [dictionary setValue:@"158" forKey:@"Темно-синий"];
    [dictionary setValue:@"160" forKey:@"Темно-сиреневый"];
    [dictionary setValue:@"162" forKey:@"Темно-фиолетовый"];
    [dictionary setValue:@"166" forKey:@"Торнадо"];
    [dictionary setValue:@"167" forKey:@"Триумф"];
    [dictionary setValue:@"192" forKey:@"Фея"];
    [dictionary setValue:@"168" forKey:@"Фиолетовый"];
    [dictionary setValue:@"170" forKey:@"Хаки"];
    [dictionary setValue:@"171" forKey:@"Чайная роза"];
    [dictionary setValue:@"174" forKey:@"Чароит"];
    [dictionary setValue:@"172" forKey:@"Черный"];
    [dictionary setValue:@"228" forKey:@"Черный эбонит"];
    [dictionary setValue:@"182" forKey:@"Ярко-белый"];
    [dictionary setValue:@"278" forKey:@"Ярко-белый люкс"];
    [dictionary setValue:@"268" forKey:@"Ярко-зеленый"];
    [dictionary setValue:@"236" forKey:@"Ярко-красный"];
    [dictionary setValue:@"206" forKey:@"Ярко-синий"];
    [dictionary setValue:@"251" forKey:@"Ярко-фиолетовый"];
    
    return dictionary;
}


#pragma mark - BodyTypes

+ (NSDictionary *)BodyTypesRusForeign
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"внедорожник"];
    [dictionary setValue:@"1" forKey:@"кабриолет"];
    [dictionary setValue:@"2" forKey:@"кроссовер"];
    [dictionary setValue:@"3" forKey:@"купе"];
    [dictionary setValue:@"4" forKey:@"лимузин"];
    [dictionary setValue:@"5" forKey:@"минивэн"];
    [dictionary setValue:@"6" forKey:@"пикап"];
    [dictionary setValue:@"7" forKey:@"родстер"];
    [dictionary setValue:@"8" forKey:@"седан"];
    [dictionary setValue:@"9" forKey:@"хетчбэк"];
    [dictionary setValue:@"10" forKey:@"универсал"];
    [dictionary setValue:@"11" forKey:@"компактвэн"];
    [dictionary setValue:@"12" forKey:@"фургон"];
    [dictionary setValue:@"13" forKey:@"шасси"];
    
    return dictionary;
}

+ (NSDictionary *)BodyTypesBuses
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"201" forKey:@"Вахтовый"];
    [dictionary setValue:@"202" forKey:@"Городской"];
    [dictionary setValue:@"203" forKey:@"Междугородный"];
    [dictionary setValue:@"204" forKey:@"Пригородный"];
    [dictionary setValue:@"205" forKey:@"Cпециальный"];
    [dictionary setValue:@"206" forKey:@"Туристический"];
    [dictionary setValue:@"207" forKey:@"Школьный"];
    
    return dictionary;
}

+ (NSDictionary *)BodyTypesTrucks
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"11" forKey:@"Автобетононасос"];
    [dictionary setValue:@"12" forKey:@"Автовоз"];
    [dictionary setValue:@"13" forKey:@"Автовышка"];
    [dictionary setValue:@"14" forKey:@"Автокран"];
    [dictionary setValue:@"15" forKey:@"Автопоезд"];
    [dictionary setValue:@"16" forKey:@"Автоцистерна"];
    [dictionary setValue:@"17" forKey:@"Автоцистерна топливозаправочная"];
    [dictionary setValue:@"18" forKey:@"Бензовоз"];
    [dictionary setValue:@"19" forKey:@"Бетоносмеситель"];
    [dictionary setValue:@"20" forKey:@"Бортовой грузовик"];
    [dictionary setValue:@"21" forKey:@"Бортовой грузовик + кран"];
    [dictionary setValue:@"22" forKey:@"Бортовой тентованный"];
    [dictionary setValue:@"23" forKey:@"Вакуумная машина"];
    [dictionary setValue:@"24" forKey:@"Вахтовый автобус"];
    [dictionary setValue:@"25" forKey:@"Грузовик"];
    [dictionary setValue:@"26" forKey:@"Лесовоз"];
    [dictionary setValue:@"27" forKey:@"Манипулятор"];
    [dictionary setValue:@"28" forKey:@"Мусоровоз"];
    [dictionary setValue:@"29" forKey:@"Платформа"];
    [dictionary setValue:@"30" forKey:@"Полуприцеп"];
    [dictionary setValue:@"31" forKey:@"Рефрижератор"];
    [dictionary setValue:@"32" forKey:@"Самосвал"];
    [dictionary setValue:@"33" forKey:@"Седельный тягач"];
    [dictionary setValue:@"34" forKey:@"Сортиментовоз"];
    [dictionary setValue:@"35" forKey:@"Тентованный шторный"];
    [dictionary setValue:@"36" forKey:@"Топливозаправщик"];
    [dictionary setValue:@"37" forKey:@"Фургон"];
    [dictionary setValue:@"38" forKey:@"Фургон изотермический"];
    [dictionary setValue:@"39" forKey:@"Фургон мебельный"];
    [dictionary setValue:@"40" forKey:@"Фургон промтоварный"];
    [dictionary setValue:@"41" forKey:@"Фургон рефрижератор"];
    [dictionary setValue:@"42" forKey:@"Шасси"];
    [dictionary setValue:@"43" forKey:@"Эвакуатор"];
    
    return dictionary;
}

+ (NSDictionary *)BodyTypesSmall
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"30" forKey:@"Автобус"];
    [dictionary setValue:@"31" forKey:@"Бортовой грузовик"];
    [dictionary setValue:@"32" forKey:@"Внедорожник"];
    [dictionary setValue:@"33" forKey:@"Микроавтобус"];
    [dictionary setValue:@"34" forKey:@"Минивэн"];
    [dictionary setValue:@"35" forKey:@"Пикап"];
    [dictionary setValue:@"36" forKey:@"Рефрижератор"];
    [dictionary setValue:@"37" forKey:@"Фургон"];
    [dictionary setValue:@"38" forKey:@"Фургон грузовой"];
    [dictionary setValue:@"39" forKey:@"Фургон изотермический"];
    [dictionary setValue:@"40" forKey:@"Фургон промтоварный"];
    [dictionary setValue:@"41" forKey:@"Фургон рефрижератор"];
    [dictionary setValue:@"42" forKey:@"Шасси"];
    [dictionary setValue:@"43" forKey:@"Эвакуатор"];
    
    return dictionary;
}

+ (NSDictionary *)BodyTypesTrailers
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"71" forKey:@"Автовоз"];
    [dictionary setValue:@"72" forKey:@"Автоцистерна"];
    [dictionary setValue:@"73" forKey:@"Контейнеровоз"];
    [dictionary setValue:@"74" forKey:@"Полуприцеп"];
    [dictionary setValue:@"75" forKey:@"Полуприцеп бортовой"];
    [dictionary setValue:@"76" forKey:@"Полуприцеп низкорамный трал"];
    [dictionary setValue:@"77" forKey:@"Полуприцеп рефрижератор"];
    [dictionary setValue:@"78" forKey:@"Полуприцеп самосвальный"];
    [dictionary setValue:@"79" forKey:@"Полуприцеп тентованный"];
    [dictionary setValue:@"80" forKey:@"Полуприцеп тяжеловоз"];
    [dictionary setValue:@"81" forKey:@"Полуприцеп электростанция"];
    [dictionary setValue:@"82" forKey:@"Прицеп"];
    [dictionary setValue:@"83" forKey:@"Прицеп бортовой"];
    [dictionary setValue:@"84" forKey:@"Прицеп самосвальный"];
    [dictionary setValue:@"85" forKey:@"Прицеп тентованный"];
    [dictionary setValue:@"86" forKey:@"Прицеп тяжеловоз"];
    [dictionary setValue:@"87" forKey:@"Прицеп фургон"];
    [dictionary setValue:@"88" forKey:@"Прицеп шасси"];
    [dictionary setValue:@"89" forKey:@"Рефрижератор"];
    [dictionary setValue:@"90" forKey:@"Сортиментовоз"];
    [dictionary setValue:@"91" forKey:@"Фургон"];
    [dictionary setValue:@"92" forKey:@"Фургон изотермический"];
    [dictionary setValue:@"93" forKey:@"Фургон мебельный"];
    [dictionary setValue:@"94" forKey:@"Фургон промтоварный"];
    [dictionary setValue:@"95" forKey:@"Фургон рефрижератор"];
    [dictionary setValue:@"96" forKey:@"Цементовоз"];
    
    return dictionary;
}

+ (NSDictionary *)BodyTypesSpecial
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"101" forKey:@"Аварийно-ремонтная"];
    [dictionary setValue:@"102" forKey:@"Автобетоносмеситель"];
    [dictionary setValue:@"103" forKey:@"Автовышка"];
    [dictionary setValue:@"104" forKey:@"Автодом"];
    [dictionary setValue:@"105" forKey:@"Автокран"];
    [dictionary setValue:@"106" forKey:@"Автопогрузчик"];
    [dictionary setValue:@"107" forKey:@"Ассенизатор"];
    [dictionary setValue:@"108" forKey:@"Башенный кран"];
    [dictionary setValue:@"109" forKey:@"Бетономешалка"];
    [dictionary setValue:@"110" forKey:@"Бетононасос"];
    [dictionary setValue:@"111" forKey:@"Бетоносмеситель"];
    [dictionary setValue:@"111" forKey:@"Бульдозер"];
    [dictionary setValue:@"112" forKey:@"Бурильно-сваебойная машина"];
    [dictionary setValue:@"113" forKey:@"Буровая установка"];
    [dictionary setValue:@"114" forKey:@"Вакуумная машина"];
    [dictionary setValue:@"115" forKey:@"Грейдер"];
    [dictionary setValue:@"116" forKey:@"Дробильно-сортировочная установка"];
    [dictionary setValue:@"117" forKey:@"Автоцистерна топливозаправочная"];
    [dictionary setValue:@"118" forKey:@"Каналоочистительная машина"];
    [dictionary setValue:@"119" forKey:@"Каток"];
    [dictionary setValue:@"120" forKey:@"Комбайн"];
    [dictionary setValue:@"121" forKey:@"Комбинированная"];
    [dictionary setValue:@"122" forKey:@"Мусоровоз"];
    [dictionary setValue:@"123" forKey:@"Пескоразбрасывающая"];
    [dictionary setValue:@"124" forKey:@"Погрузчик"];
    [dictionary setValue:@"125" forKey:@"Поливомоечная"];
    [dictionary setValue:@"126" forKey:@"Подметально-уборочная"];
    [dictionary setValue:@"127" forKey:@"Самопогрузчик"];
    [dictionary setValue:@"128" forKey:@"Самосвал"];
    [dictionary setValue:@"129" forKey:@"Свеклоуборочный комбайн"];
    [dictionary setValue:@"130" forKey:@"Снегоочиститель"];
    [dictionary setValue:@"131" forKey:@"Трактор гусеничный"];
    [dictionary setValue:@"132" forKey:@"Трактор колесный"];
    [dictionary setValue:@"133" forKey:@"Трактор малогабаритный"];
    [dictionary setValue:@"134" forKey:@"Трубоукладчик"];
    [dictionary setValue:@"135" forKey:@"Цементировочный агрегат"];
    [dictionary setValue:@"136" forKey:@"Экскаватор"];
    [dictionary setValue:@"137" forKey:@"Тягач"];
    [dictionary setValue:@"138" forKey:@"Автозаправщик"];
    [dictionary setValue:@"139" forKey:@"Бензовоз"];
    
    return dictionary;
}

+ (NSDictionary *)BodyTypesBikes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"150" forKey:@"Allround"];
    [dictionary setValue:@"151" forKey:@"Naked bike"];
    [dictionary setValue:@"152" forKey:@"Speedway"];
    [dictionary setValue:@"153" forKey:@"Super motard"];
    [dictionary setValue:@"154" forKey:@"Внедорожный Эндуро"];
    [dictionary setValue:@"155" forKey:@"Детский"];
    [dictionary setValue:@"156" forKey:@"Дорожный"];
    [dictionary setValue:@"157" forKey:@"Кастом"];
    [dictionary setValue:@"158" forKey:@"Классик"];
    [dictionary setValue:@"159" forKey:@"Кросс"];
    [dictionary setValue:@"160" forKey:@"Круизер"];
    [dictionary setValue:@"161" forKey:@"Минибайк"];
    [dictionary setValue:@"162" forKey:@"Прототип"];
    [dictionary setValue:@"163" forKey:@"Спорт-байк"];
    [dictionary setValue:@"164" forKey:@"Спорт-туризм"];
    [dictionary setValue:@"165" forKey:@"Супер-спорт"];
    [dictionary setValue:@"166" forKey:@"Трайки"];
    [dictionary setValue:@"167" forKey:@"Туризм"];
    [dictionary setValue:@"168" forKey:@"Туристический Эндуро"];
    [dictionary setValue:@"169" forKey:@"Чоппер"];
    
    return dictionary;
}


#pragma mark - DriveTypes

+ (NSDictionary *)DriveTypesRusForeign
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Передний"];
    [dictionary setValue:@"1" forKey:@"Задний"];
    [dictionary setValue:@"2" forKey:@"Полный"];
    
    return dictionary;
}

+ (NSDictionary *)DriveTypesBusesSmallSpecial
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"14" forKey:@"Передний"];
    [dictionary setValue:@"15" forKey:@"Задний"];
    [dictionary setValue:@"16" forKey:@"Полный"];
    [dictionary setValue:@"17" forKey:@"С раздачей"];
    
    return dictionary;
}

+ (NSDictionary *)DriveTypesTrucks
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"3" forKey:@"4x2"];
    [dictionary setValue:@"4" forKey:@"4x4"];
    [dictionary setValue:@"5" forKey:@"6x2"];
    [dictionary setValue:@"6" forKey:@"6x4"];
    [dictionary setValue:@"7" forKey:@"6x6"];
    [dictionary setValue:@"8" forKey:@"8x2"];
    [dictionary setValue:@"9" forKey:@"8x4"];
    [dictionary setValue:@"10" forKey:@"8x6"];
    [dictionary setValue:@"11" forKey:@"8x8"];
    [dictionary setValue:@"12" forKey:@"10x6"];
    [dictionary setValue:@"13" forKey:@"12x8"];
    
    return dictionary;
}


#pragma mark - CabinTypes

+ (NSDictionary *)CabinTypes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"2-х местная без спального"];
    [dictionary setValue:@"1" forKey:@"2-х местная с 1 спальным"];
    [dictionary setValue:@"2" forKey:@"2-х местная с 2 спальными"];
    [dictionary setValue:@"3" forKey:@"3-х местная без спального"];
    [dictionary setValue:@"4" forKey:@"3-х местная с 1 спальным"];
    [dictionary setValue:@"5" forKey:@"7-и местная, двухрядная"];
    
    return dictionary;
}


#pragma mark - Other

+ (NSDictionary *)WheelMaterials
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Алюминиевый сплав"];
    [dictionary setValue:@"2" forKey:@"Магниевый сплав"];
    [dictionary setValue:@"3" forKey:@"Сталь"];
    [dictionary setValue:@"4" forKey:@"Сталь + алюминий"];
    [dictionary setValue:@"5" forKey:@"Титановый сплав"];
    
    return dictionary;
}

+ (NSDictionary *)SpikesTypes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Есть"];
    [dictionary setValue:@"0" forKey:@"Нет"];
    
    return dictionary;
}

+ (NSDictionary *)TiresWidthes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (int i = 135; i <= 405; i += 10) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"455" forKey:@"455"];
    
    return dictionary;
}

+ (NSDictionary *)TiresHeights
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (int i = 25; i <= 95; i += 5) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    
    return dictionary;
}

+ (NSDictionary *)TiresDiameters
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (int i = 12; i <= 17; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"17.5" forKey:@"17.5"];
    [dictionary setValue:@"18" forKey:@"18"];
    [dictionary setValue:@"19" forKey:@"19"];
    [dictionary setValue:@"19.5" forKey:@"19.5"];
    [dictionary setValue:@"20" forKey:@"20"];
    [dictionary setValue:@"21" forKey:@"21"];
    [dictionary setValue:@"22" forKey:@"22"];
    [dictionary setValue:@"22.5" forKey:@"22.5"];
    [dictionary setValue:@"23" forKey:@"23"];
    
    return dictionary;
}

+ (NSDictionary *)WheelDiameters
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (int i = 12; i <= 23; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    
    return dictionary;
}

+ (NSDictionary *)WheelSorties
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    
    [dictionary setValue:@"-63" forKey:@"-63"];
    [dictionary setValue:@"-50" forKey:@"-50"];
    [dictionary setValue:@"-49" forKey:@"-49"];
    [dictionary setValue:@"-46" forKey:@"-46"];
    [dictionary setValue:@"-44" forKey:@"-44"];
    [dictionary setValue:@"-40" forKey:@"-40"];
    [dictionary setValue:@"-38" forKey:@"-38"];
    [dictionary setValue:@"-30" forKey:@"-30"];
    [dictionary setValue:@"-28" forKey:@"-28"];
    [dictionary setValue:@"-25" forKey:@"-25"];
    [dictionary setValue:@"-24" forKey:@"-24"];
    [dictionary setValue:@"-20" forKey:@"-20"];
    [dictionary setValue:@"-19" forKey:@"-19"];
    [dictionary setValue:@"-18" forKey:@"-18"];
    for (int i = -15; i <= -10; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"-6" forKey:@"-6"];
    [dictionary setValue:@"-5" forKey:@"-5"];
    [dictionary setValue:@"-3" forKey:@"-3"];
    for (int i = 0; i <= 20; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"20.5" forKey:@"20.5"];
    [dictionary setValue:@"20.8" forKey:@"20.8"];
    for (int i = 22; i <= 27; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"27.5" forKey:@"27.5"];
    [dictionary setValue:@"28" forKey:@"28"];
    [dictionary setValue:@"29" forKey:@"29"];
    [dictionary setValue:@"30" forKey:@"30"];
    [dictionary setValue:@"30.5" forKey:@"30.5"];
    [dictionary setValue:@"31.5" forKey:@"31.5"];
    for (int i = 32; i <= 36; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"36.5" forKey:@"36.5"];
    [dictionary setValue:@"37" forKey:@"37"];
    [dictionary setValue:@"37.5" forKey:@"37.5"];
    [dictionary setValue:@"38" forKey:@"38"];
    [dictionary setValue:@"38.8" forKey:@"38.8"];
    [dictionary setValue:@"39" forKey:@"39"];
    [dictionary setValue:@"40" forKey:@"40"];
    [dictionary setValue:@"40.75" forKey:@"40.75"];
    [dictionary setValue:@"41" forKey:@"41"];
    [dictionary setValue:@"41.2" forKey:@"41.2"];
    [dictionary setValue:@"41.3" forKey:@"41.3"];
    [dictionary setValue:@"41.5" forKey:@"41.5"];
    [dictionary setValue:@"42" forKey:@"42"];
    [dictionary setValue:@"42.5" forKey:@"42.5"];
    [dictionary setValue:@"43" forKey:@"43"];
    [dictionary setValue:@"43.5" forKey:@"43.5"];
    [dictionary setValue:@"43.8" forKey:@"43.8"];
    [dictionary setValue:@"44" forKey:@"44"];
    [dictionary setValue:@"44.5" forKey:@"44.5"];
    [dictionary setValue:@"45" forKey:@"45"];
    [dictionary setValue:@"45.5" forKey:@"45.5"];
    [dictionary setValue:@"46" forKey:@"46"];
    [dictionary setValue:@"47" forKey:@"47"];
    [dictionary setValue:@"47.5" forKey:@"47.5"];
    [dictionary setValue:@"48" forKey:@"48"];
    [dictionary setValue:@"49" forKey:@"49"];
    [dictionary setValue:@"49.5" forKey:@"49.5"];
    [dictionary setValue:@"50" forKey:@"50"];
    [dictionary setValue:@"50.5" forKey:@"50.5"];
    [dictionary setValue:@"50.8" forKey:@"50.8"];
    [dictionary setValue:@"51" forKey:@"51"];
    [dictionary setValue:@"52" forKey:@"52"];
    [dictionary setValue:@"52.2" forKey:@"52.2"];
    [dictionary setValue:@"52.4" forKey:@"52.4"];
    [dictionary setValue:@"52.5" forKey:@"52.5"];
    [dictionary setValue:@"53" forKey:@"53"];
    [dictionary setValue:@"53.3" forKey:@"53.3"];
    for (int i = 54; i <= 60; i++) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"60.1" forKey:@"60.1"];
    [dictionary setValue:@"62" forKey:@"62"];
    [dictionary setValue:@"63" forKey:@"63"];
    [dictionary setValue:@"63.35" forKey:@"63.35"];
    [dictionary setValue:@"64" forKey:@"64"];
    [dictionary setValue:@"65" forKey:@"65"];
    [dictionary setValue:@"66" forKey:@"66"];
    [dictionary setValue:@"70" forKey:@"70"];
    [dictionary setValue:@"75" forKey:@"75"];
    [dictionary setValue:@"83" forKey:@"83"];
    [dictionary setValue:@"89.1" forKey:@"89.1"];
    [dictionary setValue:@"90" forKey:@"90"];
    [dictionary setValue:@"102" forKey:@"102"];
    [dictionary setValue:@"105" forKey:@"105"];
    [dictionary setValue:@"105.5" forKey:@"105.5"];
    [dictionary setValue:@"107" forKey:@"107"];
    [dictionary setValue:@"108" forKey:@"108"];
    [dictionary setValue:@"110.5" forKey:@"110.5"];
    [dictionary setValue:@"115" forKey:@"115"];
    [dictionary setValue:@"120" forKey:@"120"];
    [dictionary setValue:@"123" forKey:@"123"];
    [dictionary setValue:@"124" forKey:@"124"];
    [dictionary setValue:@"132" forKey:@"132"];
    
    return dictionary;
}

+ (NSDictionary *)WheelWidthes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (float i = 4; i <= 11; i += 0.5) {
        NSString *value = [NSString stringWithFormat:@"%0.1f", i];
        [dictionary setValue:value forKey:value];
    }
    
    return dictionary;
}

+ (NSDictionary *)WheelHoleDiameters
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"98" forKey:@"98"];
    [dictionary setValue:@"100" forKey:@"100"];
    [dictionary setValue:@"108" forKey:@"108"];
    [dictionary setValue:@"110" forKey:@"110"];
    [dictionary setValue:@"112" forKey:@"112"];
    [dictionary setValue:@"114" forKey:@"114"];
    [dictionary setValue:@"114.3" forKey:@"114.3"];
    [dictionary setValue:@"115" forKey:@"115"];
    [dictionary setValue:@"118" forKey:@"118"];
    [dictionary setValue:@"120" forKey:@"120"];
    [dictionary setValue:@"120.6" forKey:@"120.6"];
    [dictionary setValue:@"120.65" forKey:@"120.65"];
    [dictionary setValue:@"120.7" forKey:@"120.7"];
    [dictionary setValue:@"127" forKey:@"127"];
    [dictionary setValue:@"130" forKey:@"130"];
    [dictionary setValue:@"135" forKey:@"135"];
    [dictionary setValue:@"139" forKey:@"139"];
    [dictionary setValue:@"139.7" forKey:@"139.7"];
    [dictionary setValue:@"150" forKey:@"150"];
    [dictionary setValue:@"160" forKey:@"160"];
    [dictionary setValue:@"165" forKey:@"165"];
    [dictionary setValue:@"165.1" forKey:@"165.1"];
    [dictionary setValue:@"170" forKey:@"170"];
    [dictionary setValue:@"180" forKey:@"180"];
    [dictionary setValue:@"190" forKey:@"190"];
    [dictionary setValue:@"205" forKey:@"205"];
    [dictionary setValue:@"225" forKey:@"225"];
    [dictionary setValue:@"256" forKey:@"256"];
    [dictionary setValue:@"275" forKey:@"275"];
    [dictionary setValue:@"335" forKey:@"335"];
    
    return dictionary;
}

+ (NSDictionary *)WheelHoleCounts
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (int i = 1; i <= 10; i += 1) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    
    return dictionary;
}

+ (NSDictionary *)WheelTypes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Штампованные"];
    [dictionary setValue:@"2" forKey:@"Литые"];
    [dictionary setValue:@"3" forKey:@"Кованые"];
    [dictionary setValue:@"4" forKey:@"Сборные"];
    
    return dictionary;
}

+ (NSDictionary *)Seasonalities
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"2" forKey:@"Зимние"];
    [dictionary setValue:@"3" forKey:@"Летние"];
    [dictionary setValue:@"1" forKey:@"Всесезонные"];
    
    return dictionary;
}

+ (NSDictionary *)TrailerDestinies
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Для перевозки грузов"];
    [dictionary setValue:@"2" forKey:@"Для катера, лодки, гидроцикла"];
    [dictionary setValue:@"3" forKey:@"Для снегоходов, квадроциклов"];
    [dictionary setValue:@"4" forKey:@"Легковые автовозы"];
    
    return dictionary;
}

+ (NSDictionary *)AdPeriods
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"2 недели"];
    [dictionary setValue:@"1" forKey:@"4 недели"];
    [dictionary setValue:@"2" forKey:@"6 недели"];
    [dictionary setValue:@"3" forKey:@"8 недели"];
    
    return dictionary;
}

+ (NSDictionary *)Bools
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Да"];
    [dictionary setValue:@"1" forKey:@"Нет"];
    
    return dictionary;
}

+ (NSDictionary *)GearsStates
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"10" forKey:@"Б/у"];
    [dictionary setValue:@"11" forKey:@"Новое"];
    
    return dictionary;
}

+ (NSDictionary *)WaterStates
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Отличное"];
    [dictionary setValue:@"1" forKey:@"Хорошее"];
    [dictionary setValue:@"2" forKey:@"Среднее"];
    
    return dictionary;
}

+ (NSDictionary *)CarStates
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Отличное"];
    [dictionary setValue:@"1" forKey:@"Хорошее"];
    [dictionary setValue:@"2" forKey:@"Среднее"];
    [dictionary setValue:@"3" forKey:@"Битый"];
    [dictionary setValue:@"4" forKey:@"Аварийный"];
    [dictionary setValue:@"5" forKey:@"На запчасти"];
    
    return dictionary;
}

+ (NSDictionary *)HydrosStates
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Cпортивно-туристический"];
    [dictionary setValue:@"2" forKey:@"Спортивный"];
    [dictionary setValue:@"3" forKey:@"Спортивный стоячий"];
    [dictionary setValue:@"4" forKey:@"Туристический"];
    
    return dictionary;
}

+ (NSDictionary *)EngineCapacities
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    for (float i = 0.5; i <= 8.0; i += 0.1) {
        NSString *value = [NSString stringWithFormat:@"%f", i];
        [dictionary setValue:value forKey:value];
    }
    [dictionary setValue:@"999" forKey:@"более 8.0"];
    
    return dictionary;
}

+ (NSDictionary *)FuelTypes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"4" forKey:@"Дизельное"];
    [dictionary setValue:@"2" forKey:@"Бензин"];
    [dictionary setValue:@"1" forKey:@"Газ"];
    [dictionary setValue:@"8" forKey:@"Электро"];
    [dictionary setValue:@"16" forKey:@"Гибрид"];
    
    return dictionary;
}

+ (NSDictionary *)Rudder
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Руль левый"];
    [dictionary setValue:@"1" forKey:@"Руль правый"];
    
    return dictionary;
}

+ (NSDictionary *)GearboxTypes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Автомат"];
    [dictionary setValue:@"1" forKey:@"Вариатор"];
    [dictionary setValue:@"2" forKey:@"Механическая"];
    [dictionary setValue:@"3" forKey:@"Роботизированная"];
    
    return dictionary;
}

+ (NSDictionary *)GearboxTypesTrucks
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"Автоматическая"];
    [dictionary setValue:@"2" forKey:@"Механическая"];
    
    return dictionary;
}

+ (NSDictionary *)GearboxTypesMKT
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"0" forKey:@"автоматическая"];
    [dictionary setValue:@"1" forKey:@"вариаторная"];
    [dictionary setValue:@"2" forKey:@"механическая"];
    [dictionary setValue:@"3" forKey:@"секвентальная"];
    
    return dictionary;
}

+ (NSDictionary *)EngineTypes
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Карбюраторный"];
    [dictionary setValue:@"2" forKey:@"Инжекторный"];
    
    return dictionary;
}

+ (NSDictionary *)Years
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentYear = [components year];
    
    for (int i = 1950; i <= currentYear; i += 1) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    
    return dictionary;
}

+ (NSDictionary *)Counts
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    
    for (int i = 1; i <= 10; i += 1) {
        NSString *value = [NSString stringWithFormat:@"%d", i];
        [dictionary setValue:value forKey:value];
    }
    
    return dictionary;
}

+ (NSDictionary *)ModerateStatuses
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"1" forKey:@"Запрещается размещение дубликатов объявлений в одном разделе."];
    [dictionary setValue:@"2" forKey:@"Информация, указанная в объявлении, должна соответствовать разделу."];
    [dictionary setValue:@"3" forKey:@"Запрещается использовать в объявлениях информацию рекламного характера, ссылки на сайты, документы."];
    [dictionary setValue:@"4" forKey:@"Текст объявления должен быть набран кириллицей. Запрещается набирать текст или некоторые слова целиком заглавными буквами, выделять цветом, использовать посторонние символы и так далее."];
    [dictionary setValue:@"5" forKey:@"Запрещается размещать объявления с недостоверными данными."];
    [dictionary setValue:@"6" forKey:@"Не верно указан формат  мобильного телефона. Код оператора (три цифры)  надо писать отдельно. Пример правильного заполнения:  8 (922) 1234567."];
    
    return dictionary;
}


#pragma mark - Subrubrics

+ (NSDictionary *)SubrubricsMotors
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"rus" forKey:@"Отечественные авто"];
    [dictionary setValue:@"foreign" forKey:@"Иномарки"];
    [dictionary setValue:@"trailers" forKey:@"Прицепы"];
    
    return dictionary;
}

+ (NSDictionary *)SubrubricsCommercial
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"buses" forKey:@"Автобусы"];
    [dictionary setValue:@"trucks" forKey:@"Грузовые автомобили"];
    [dictionary setValue:@"small" forKey:@"Малый коммерческий транспорт"];
    [dictionary setValue:@"trailers" forKey:@"Грузовые прицепы и полуприцепы"];
    [dictionary setValue:@"special" forKey:@"Спецтехника"];
    
    return dictionary;
}

+ (NSDictionary *)SubrubricsMoto
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"bikes" forKey:@"Мотоциклы и мопеды"];
    [dictionary setValue:@"quadro" forKey:@"Квадроциклы"];
    [dictionary setValue:@"scooter" forKey:@"Скутеры"];
    [dictionary setValue:@"snow" forKey:@"Снегоходы"];
    
    return dictionary;
}

+ (NSDictionary *)SubrubricsWater
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"hydros" forKey:@"Гидроциклы"];
    [dictionary setValue:@"yachts" forKey:@"Катера и яхты"];
    [dictionary setValue:@"boats" forKey:@"Лодки"];
    
    return dictionary;
}

+ (NSDictionary *)SubrubricsParts
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"wheels" forKey:@"Диски"];
    [dictionary setValue:@"tires" forKey:@"Шины"];
    
    return dictionary;
}


#pragma mark - Main

+ (NSDictionary *)Rubrics
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"motors" forKey:@"Легковые автомобили"];
    [dictionary setValue:@"commercial" forKey:@"Коммерческий транспорт"];
    [dictionary setValue:@"moto" forKey:@"Мототехника"];
    [dictionary setValue:@"water" forKey:@"Водный транспорт"];
    [dictionary setValue:@"gears" forKey:@"Шины и диски"];
    [dictionary setValue:@"parts" forKey:@"Автозапчасти"];
    
    return dictionary;
}

+ (NSDictionary *)RubricsWithSubrubrics
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:[AdvDictionaries SubrubricsMotors] forKey:@"Легковые автомобили"];
    [dictionary setValue:[AdvDictionaries SubrubricsCommercial] forKey:@"Коммерческий транспорт"];
    [dictionary setValue:[AdvDictionaries SubrubricsMoto] forKey:@"Мототехника"];
    [dictionary setValue:[AdvDictionaries SubrubricsWater] forKey:@"Водный транспорт"];
    [dictionary setValue:[AdvDictionaries SubrubricsParts] forKey:@"Шины и диски"];
    [dictionary setValue:nil forKey:@"Автозапчасти"];
    
    return dictionary;
}

+ (NSDictionary *)RubricsForAutoparts
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"motors" forKey:@"Легковые автомобили"];
    [dictionary setValue:@"commercial" forKey:@"Коммерческий транспорт"];
    [dictionary setValue:@"moto" forKey:@"Мототехника"];
    [dictionary setValue:@"water" forKey:@"Водный транспорт"];
    
    return dictionary;
}


+ (NSDictionary *)HostLinks
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"74" forKey:@"autochel.ru"];
    [dictionary setValue:@"2" forKey:@"102km.ru"];
    [dictionary setValue:@"61" forKey:@"161auto.ru"];
    [dictionary setValue:@"72" forKey:@"72avto.ru"];
    [dictionary setValue:@"59" forKey:@"avto59.ru"];
    [dictionary setValue:@"63" forKey:@"doroga63.ru"];
    [dictionary setValue:@"34" forKey:@"34auto.ru"];
    [dictionary setValue:@"16" forKey:@"116auto.ru"];
    [dictionary setValue:@"29" forKey:@"29.ru"];
    [dictionary setValue:@"76" forKey:@"76.ru"];
    
    return dictionary;
}

+ (NSDictionary *)Regions
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:@"74" forKey:@"Челябинская область"];
    [dictionary setValue:@"2" forKey:@"Республика Башкортостан"];
    [dictionary setValue:@"61" forKey:@"Ростовская область"];
    [dictionary setValue:@"72" forKey:@"Тюменская область"];
    [dictionary setValue:@"59" forKey:@"Пермская область"];
    [dictionary setValue:@"63" forKey:@"Самарская область"];
    [dictionary setValue:@"34" forKey:@"Волгоградская область"];
    [dictionary setValue:@"16" forKey:@"Республика Татарстан"];
    [dictionary setValue:@"29" forKey:@"Архангельская область"];
    [dictionary setValue:@"76" forKey:@"Ярославская область"];
    
    return dictionary;
}


#pragma mark - Synonims

+ (NSDictionary *)SynonimsOfFields
{
    OrderedDictionary *dictionary = [OrderedDictionary new];
    [dictionary setValue:F_DIAMETER_ENG forKey:F_DIAMETER_MAX_ENG];
    [dictionary setValue:F_DIAMETER_ENG forKey:F_DIAMETER_MIN_ENG];
    [dictionary setValue:F_DISPLACEMENT_ENG forKey:F_DISPLACEMENT_MAX_ENG];
    [dictionary setValue:F_DISPLACEMENT_ENG forKey:F_DISPLACEMENT_MIN_ENG];
    [dictionary setValue:F_ENGINE_CAPACITY_ENG forKey:F_ENGINE_CAPACITY_MAX_ENG];
    [dictionary setValue:F_ENGINE_CAPACITY_ENG forKey:F_ENGINE_CAPACITY_MIN_ENG];
    [dictionary setValue:F_ENGINE_POWER_ENG forKey:F_ENGINE_POWER_MAX_ENG];
    [dictionary setValue:F_ENGINE_POWER_ENG forKey:F_ENGINE_POWER_MIN_ENG];
    [dictionary setValue:F_HEIGHT_ENG forKey:F_HEIGHT_MAX_ENG];
    [dictionary setValue:F_HEIGHT_ENG forKey:F_HEIGHT_MIN_ENG];
    [dictionary setValue:F_HOLES_COUNT_ENG forKey:F_HOLES_COUNT_MAX_ENG];
    [dictionary setValue:F_HOLES_COUNT_ENG forKey:F_HOLES_COUNT_MIN_ENG];
    [dictionary setValue:F_HOLES_DIAMETER_ENG forKey:F_HOLES_DIAMETER_MAX_ENG];
    [dictionary setValue:F_HOLES_DIAMETER_ENG forKey:F_HOLES_DIAMETER_MIN_ENG];
    [dictionary setValue:F_MILEAGE_ENG forKey:F_MILEAGE_MAX_ENG];
    [dictionary setValue:F_MILEAGE_ENG forKey:F_MILEAGE_MIN_ENG];
    [dictionary setValue:F_PRICE_ENG forKey:F_PRICE_MAX_ENG];
    [dictionary setValue:F_PRICE_ENG forKey:F_PRICE_MIN_ENG];
    [dictionary setValue:F_SEATS_ENG forKey:F_SEATS_MAX_ENG];
    [dictionary setValue:F_SEATS_ENG forKey:F_SEATS_MIN_ENG];
    [dictionary setValue:F_WIDTH_ENG forKey:F_WIDTH_MAX_ENG];
    [dictionary setValue:F_WIDTH_ENG forKey:F_WIDTH_MIN_ENG];
    [dictionary setValue:F_YEAR_ENG forKey:F_YEAR_MAX_ENG];
    [dictionary setValue:F_YEAR_ENG forKey:F_YEAR_MIN_ENG];
    
    return dictionary;
}
@end
