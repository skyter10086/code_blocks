use v6.c;

unit module Person;


subset DateStr of Str where Date.new(*);
enum SexEnum <Male Female>;
class Person {
	has Str $.name;
        has Str $.id;
        has DateStr $.birth;
        has SexEnum $.sex;
        }

