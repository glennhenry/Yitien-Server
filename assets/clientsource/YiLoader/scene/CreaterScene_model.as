package scene
{
   import manager.Utils;
   
   public class CreaterScene_model
   {
      
      private static var _first_name:Array;
      
      private static var _send_man_name_1:Array;
      
      private static var _send_man_name_2:Array;
      
      private static var _send_women_name_1:Array;
      
      private static var _send_women_name_2:Array;
      
      public function CreaterScene_model()
      {
         super();
      }
      
      public static function getRandomUserName(sex:int) : String
      {
         var firstName0:String = null;
         var firstName1:String = null;
         var lastName:String = FIRST_NAME[Utils.rnd(0,FIRST_NAME.length - 1)];
         if(sex == 1)
         {
            firstName0 = SEND_MAN_NAME_1[Utils.rnd(0,SEND_MAN_NAME_1.length - 1)];
            firstName1 = SEND_MAN_NAME_2[Utils.rnd(0,SEND_MAN_NAME_2.length - 1)];
         }
         else if(sex == 2)
         {
            firstName0 = SEND_WOMEN_NAME_1[Utils.rnd(0,SEND_WOMEN_NAME_1.length - 1)];
            firstName1 = SEND_WOMEN_NAME_2[Utils.rnd(0,SEND_WOMEN_NAME_2.length - 1)];
         }
         return lastName + firstName0 + firstName1;
      }
      
      public static function get FIRST_NAME() : Array
      {
         if(!_first_name)
         {
            _first_name = Model_initStr.FIRST_NAME;
         }
         return _first_name;
      }
      
      public static function get SEND_MAN_NAME_1() : Array
      {
         if(!_send_man_name_1)
         {
            _send_man_name_1 = Model_initStr.SEND_MAN_NAME_1;
         }
         return _send_man_name_1;
      }
      
      public static function get SEND_MAN_NAME_2() : Array
      {
         if(!_send_man_name_2)
         {
            _send_man_name_2 = Model_initStr.SEND_MAN_NAME_2;
         }
         return _send_man_name_2;
      }
      
      public static function get SEND_WOMEN_NAME_1() : Array
      {
         if(!_send_women_name_1)
         {
            _send_women_name_1 = Model_initStr.SEND_WOMEN_NAME_1;
         }
         return _send_women_name_1;
      }
      
      public static function get SEND_WOMEN_NAME_2() : Array
      {
         if(!_send_women_name_2)
         {
            _send_women_name_2 = Model_initStr.SEND_WOMEN_NAME_2;
         }
         return _send_women_name_2;
      }
   }
}

