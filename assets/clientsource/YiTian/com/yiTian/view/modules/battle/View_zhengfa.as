package com.yiTian.view.modules.battle
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_Direct;
   import com.yiTian.data.vo.Vo_ZhenFa;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class View_zhengfa extends Sprite
   {
      
      private static var zfDic:Dictionary = new Dictionary();
      
      private var rooms:Array = [];
      
      private var _direct:int;
      
      private var zfDisp:DisplayObject;
      
      private var _zfId:int;
      
      public function View_zhengfa(direct:int)
      {
         super();
         this._direct = direct;
         var i:int = 0;
         while(i < 6)
         {
            this.rooms.push(ComponentUtil.getDisplayObject("Stand_Room",this,null,Global.battleDm));
            i++;
         }
      }
      
      public function set zfId(value:int) : void
      {
         this._zfId = Data_lib.zhenfa[value][Vo_ZhenFa.IMG];
         if(Boolean(this.zfDisp) && contains(this.zfDisp))
         {
            removeChild(this.zfDisp);
            this.zfDisp = null;
         }
         if(Boolean(zfDic[this._zfId]))
         {
            this.zfDisp = ComponentUtil.getDisplayObject("s",null,null,zfDic[this._zfId]);
            addChildAt(this.zfDisp,0);
            this.setZFRoom();
         }
         else
         {
            MassLoader.add("resource/pic_swf/" + this._zfId + ".swf",this.loadComp,null,MassLoader.LEVEL0,{"zfid":this._zfId});
         }
      }
      
      private function loadComp(info:Object) : void
      {
         if(zfDic[info.obj.zfid] == null)
         {
            zfDic[info.obj.zfid] = info.applicationDomain;
         }
         if(info.url.indexOf(this._zfId) == -1)
         {
            return;
         }
         if(Boolean(this.zfDisp) && contains(this.zfDisp))
         {
            removeChild(this.zfDisp);
            this.zfDisp = null;
         }
         this.zfDisp = ComponentUtil.getDisplayObject("s",null,null,zfDic[this._zfId]);
         addChildAt(this.zfDisp,0);
         this.setZFRoom();
      }
      
      private function setZFRoom() : void
      {
         var pos:Array = null;
         var room:DisplayObject = null;
         var positionStr:String = Data_lib.zhenfa[this._zfId][Vo_ZhenFa.WEIZHI];
         var arr:Array = positionStr.split(",");
         var i:int = 0;
         while(i < 6)
         {
            room = this.rooms[i];
            pos = GameScene.battleLayer.getBattleGrid(int(arr[i]),this._direct);
            if(this._direct == Enum_Direct.ARMY)
            {
               room.x = int(pos[0]) - 65;
               room.y = int(pos[1]) - 35;
            }
            else
            {
               room.x = int(pos[0]) - 65 - 370;
               room.y = int(pos[1]) - 35 - 205;
            }
            i++;
         }
      }
   }
}

