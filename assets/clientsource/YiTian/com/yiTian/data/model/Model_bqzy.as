package com.yiTian.data.model
{
   import com.utils.ColorConstant;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.view.modules.bianqiangzhiyin.ACG_bqzy;
   import com.yiTian.view.modules.bianqiangzhiyin.Vo_Bqzy;
   
   public class Model_bqzy
   {
      
      public static var data:Vector.<Vo_Bqzy>;
      
      public static var Init:Boolean;
      
      public function Model_bqzy()
      {
         super();
      }
      
      public static function getListData() : Array
      {
         var acg:ACG_bqzy = null;
         var status:int = 0;
         var str_name:String = null;
         var obj:Object = null;
         var ii:int = 0;
         var id:int = 0;
         var color:int = 0;
         var libs:DictionaryTabel = null;
         if(!data || !data.length)
         {
            return [];
         }
         var temp:Vector.<ACG_bqzy> = new Vector.<ACG_bqzy>();
         var lib:DictionaryTabel = Data_lib.bianqiangzhiyin;
         var arr:Array = lib.toArray();
         var len:int = int(arr.length);
         var i:int = 1;
         while(i <= len)
         {
            acg = new ACG_bqzy();
            acg.change = lib[i][2];
            acg.changeLvl = lib[i][3];
            acg.target = lib[i][1];
            acg.defult = lib[i][0];
            acg.content_1 = lib[i][4];
            acg.content_2 = lib[i][5];
            temp.push(acg);
            i++;
         }
         var reslut:Array = [];
         var index:int = 0;
         len = int(data.length);
         ii = 0;
         while(ii < len)
         {
            index = data[ii].index - 1;
            status = data[ii].status;
            if(status != 3)
            {
               obj = new Object();
               str_name = "";
               obj.flag = status == 1 ? temp[index].defult : temp[index].change;
               if(data[ii].params > 0)
               {
                  switch(index + 1)
                  {
                     case 1:
                        id = data[ii].params;
                        color = int(Data_lib.equip[id][Enum_lib_equip.COLOR]);
                        str_name = "<font color=\'#" + ColorConstant.getColorStr(color) + "\'>" + Data_lib.equip[id][Enum_lib_equip.STR_NAME] + "</font>";
                        break;
                     case 3:
                        libs = Data_lib.wing;
                        if(data[ii].params > libs.getLength())
                        {
                           str_name = "";
                           break;
                        }
                        str_name = "<font color=\'#ffffff\'>" + Data_lib.wing[data[ii].params][0] + "（" + Data_lib.wing[data[ii].params][1] + "）</font>";
                  }
               }
               obj.title = status == 1 ? temp[index].content_1 : temp[index].content_2;
               obj.title += str_name;
               obj.title = "<font color=\'#99ff00\'>" + obj.title + "</font>";
               reslut.push(obj);
            }
            ii++;
         }
         return reslut;
      }
   }
}

