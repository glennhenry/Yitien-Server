package com.yiTian.view.modules.friends
{
   import com.yiTian.data.vo.Vo_unit;
   
   public class Model_Friends
   {
      
      public static var dataArr:Array;
      
      public static var viewItemVecArr:Array;
      
      public static var isOpenArr:Array;
      
      public static var parentArr:Array;
      
      public static var isQFriend:Boolean = true;
      
      public static var friendArr:Array = [];
      
      public static var qFriend:Array = [];
      
      public static var heatArr:Array = [];
      
      public static var crossFriendArr:Array = [];
      
      public static var crossHeatArr:Array = [];
      
      private static var _friQuestVec:Vector.<Vo_friQuest> = new Vector.<Vo_friQuest>();
      
      public static var hasNewQuest:Boolean = false;
      
      public static const FRIEND:int = 0;
      
      public static const QQFRIEND:int = 1;
      
      public static const HEAT:int = 2;
      
      public static const CROSS_FRIEND:int = 3;
      
      public static const CROSS_HEAT:int = 4;
      
      public static const CONTACt:int = 5;
      
      public function Model_Friends()
      {
         super();
      }
      
      public static function updateChongZhi(array:Array) : void
      {
         var arr:Array = null;
         var id:Number = NaN;
         var count:int = 0;
         var vo:Vo_unit = null;
         for each(arr in array)
         {
            id = Number(arr[0]);
            count = int(arr[1]);
            for each(vo in qFriend)
            {
               if(vo.id == id)
               {
                  vo.qinmidu = count;
               }
            }
         }
      }
      
      public static function hasFriendQuest(id:Number) : Boolean
      {
         var friQuest:Vo_friQuest = null;
         for each(friQuest in _friQuestVec)
         {
            if(friQuest.id == id)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function addFriendQuest(id:Number, name:String, type:int = 0) : void
      {
         var temp:Vo_friQuest = new Vo_friQuest();
         temp.id = id;
         temp.name = name;
         temp.type = type;
         _friQuestVec.push(temp);
      }
      
      public static function removeFriendQuest(name:String) : void
      {
         var i:int = _friQuestVec.length - 1;
         while(i >= 0)
         {
            if(_friQuestVec[i].name == name)
            {
               _friQuestVec.splice(i,1);
            }
            i--;
         }
      }
      
      public static function get friQuestVec() : Vector.<Vo_friQuest>
      {
         return _friQuestVec;
      }
      
      public static function addFriendVo(o:Vo_unit) : void
      {
         switch(o.relation)
         {
            case 1:
               if(o.isOnline)
               {
                  friendArr.unshift(o);
                  break;
               }
               friendArr.push(o);
               break;
            case 2:
               if(o.isOnline)
               {
                  heatArr.unshift(o);
                  break;
               }
               heatArr.push(o);
               break;
            case Enum_Friend.QFRIEND:
               if(o.isOnline)
               {
                  qFriend.unshift(o);
                  break;
               }
               qFriend.push(o);
               break;
            case Enum_Friend.CROSS_SERV_FRIEND:
               if(o.isOnline)
               {
                  crossFriendArr.unshift(o);
                  break;
               }
               crossFriendArr.push(o);
               break;
            case Enum_Friend.CROSS_SERV_HEAT:
               if(o.isOnline)
               {
                  crossHeatArr.unshift(o);
                  break;
               }
               crossHeatArr.push(o);
         }
      }
      
      public static function getFriendVoById(id:Number) : Vo_unit
      {
         var o:Vo_unit = null;
         for each(o in friendArr)
         {
            if(o.id == id)
            {
               return o;
            }
         }
         return null;
      }
      
      public static function getHeatVoById(id:Number) : Vo_unit
      {
         var o:Vo_unit = null;
         for each(o in heatArr)
         {
            if(o.id == id)
            {
               return o;
            }
         }
         return null;
      }
      
      public static function getQFriendVoById(id:Number) : Vo_unit
      {
         var o:Vo_unit = null;
         for each(o in qFriend)
         {
            if(o.id == id)
            {
               return o;
            }
         }
         return null;
      }
      
      public static function getCrossFriendVoById(id:Number) : Vo_unit
      {
         var o:Vo_unit = null;
         for each(o in crossFriendArr)
         {
            if(o.id == id)
            {
               return o;
            }
         }
         return null;
      }
      
      public static function getCrossHeatVoById(id:Number) : Vo_unit
      {
         var o:Vo_unit = null;
         for each(o in crossHeatArr)
         {
            if(o.id == id)
            {
               return o;
            }
         }
         return null;
      }
      
      public static function setData(src:Array) : void
      {
         var o:Vo_unit = null;
         for each(o in src)
         {
            if(o.id == 0)
            {
               continue;
            }
            switch(o.relation)
            {
               case 1:
                  friendArr.push(o);
                  break;
               case 2:
                  heatArr.push(o);
                  break;
               case 3:
                  qFriend.push(o);
            }
         }
      }
      
      public static function getOnLineLength(index:int) : int
      {
         var o:Vo_unit = null;
         var length:int = 0;
         for each(o in dataArr[index])
         {
            if(o.isOnline == true)
            {
               length += 1;
            }
         }
         return length;
      }
      
      public static function refresh() : void
      {
         var o:Array = null;
         for each(o in dataArr)
         {
            o.sortOn("isOnline",2);
         }
      }
      
      public static function updateInfoById(type:int, id:Number, o:Object) : void
      {
         var arr:Array = null;
         var info:Vo_unit = null;
         var friendItem:Child_FriendItem = null;
         if(!dataArr)
         {
            return;
         }
         for each(arr in dataArr)
         {
            for each(info in arr)
            {
               if(id == info.id)
               {
                  switch(type)
                  {
                     case 1:
                        info.level = o as int;
                        break;
                     case 2:
                        info.areaid = o as int;
                        break;
                     case 3:
                        info.qinmidu = o as int;
                        break;
                     case 4:
                        info.banghui = o as String;
                        break;
                     case 6:
                        info.name = o as String;
                        break;
                     case 7:
                        info.sex = o as int;
                  }
                  friendItem = getViewItemByRelationId(1,id);
                  if(Boolean(friendItem))
                  {
                     friendItem.update(info);
                  }
               }
            }
         }
      }
      
      public static function getViewItemByRelationId(relation:uint, id:Number) : Child_FriendItem
      {
         var fi:Child_FriendItem = null;
         for each(fi in viewItemVecArr[relation - 1])
         {
            if(fi.vo_info.id == id)
            {
               return fi;
            }
         }
         return null;
      }
   }
}

