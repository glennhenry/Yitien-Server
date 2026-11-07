package com.yiTian.view.modules.friends
{
   import com.ui.containers.Canvas;
   import com.yiTian.manager.UIManager;
   
   public class Child_searchFriend extends Canvas
   {
      
      private static var _instace:Child_searchFriend;
      
      private var itemVec:Vector.<Item>;
      
      private var curItemVec:Vector.<Item>;
      
      public function Child_searchFriend(wid:int = 150, hei:int = 120, scrollDirection:String = "RIGHT", setWidth:int = 0)
      {
         super(wid,hei,scrollDirection,setWidth);
         this.init();
      }
      
      public static function get instance() : Child_searchFriend
      {
         return _instace = _instace || new Child_searchFriend();
      }
      
      private function init() : void
      {
         this.itemVec = new Vector.<Item>();
         this.curItemVec = new Vector.<Item>();
         visible = false;
      }
      
      private function removeItem() : void
      {
         var it:Item = null;
         for each(it in this.curItemVec)
         {
            removeChild(it);
         }
         this.curItemVec.splice(0,this.curItemVec.length);
      }
      
      public function hide() : void
      {
         this.removeItem();
      }
      
      public function show(voArr:Array) : void
      {
         var it:Item = null;
         if(!UIManager.friendPanel.visible)
         {
            UIManager.friendPanel.visible = true;
         }
         this.removeItem();
         visible = true;
         var index:int = 0;
         while(index < voArr.length)
         {
            it = this.getItem();
            it.vo = voArr[index];
            addChild(it);
            this.curItemVec.push(it);
            index++;
         }
         this.sort();
         align();
      }
      
      private function sort() : void
      {
         var index:int = 0;
         while(index < this.itemVec.length)
         {
            this.itemVec[index].y = index * 20;
            index++;
         }
      }
      
      private function getItem() : Item
      {
         var it:Item = null;
         var newIt:Item = null;
         for each(it in this.itemVec)
         {
            if(it.parent == null)
            {
               return it;
            }
         }
         newIt = new Item();
         this.itemVec.push(newIt);
         return newIt;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.vo.Vo_unit;
import com.yiTian.manager.UIManager;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.friends.Child_searchFriend;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Item extends Sprite
{
   
   private var bm_head:Bitmap;
   
   private var tf_name:MyTextField;
   
   private var _vo:Vo_unit;
   
   public function Item()
   {
      super();
      this.init();
   }
   
   public function set vo(value:Vo_unit) : void
   {
      this._vo = value;
      var num:int = 23000 + Enum_job.getBaseJob(value.job) * 100 + 30 + value.sex;
      this.bm_head = Utils.getLoadBitmap("resource/image/icon/" + num.toString() + ".jpg",this.bm_head);
      if(value.isOnline == true)
      {
         this.bm_head.filters = [];
      }
      else
      {
         this.bm_head.filters = Util.disabled;
      }
      this.rName = this._vo.name;
   }
   
   public function set rName(v:String) : void
   {
      this.tf_name.text = v;
   }
   
   private function init() : void
   {
      this.bm_head = new Bitmap();
      this.bm_head.x = 2;
      this.bm_head.y = 2;
      addChild(ComponentUtil.getShape(120,20,6710886));
      addChild(this.bm_head);
      this.tf_name = ComponentUtil.getTextField("",this,{
         "x":25,
         "y":2
      });
      addEventListener(MouseEvent.CLICK,this.clickHandle);
   }
   
   private function clickHandle(evt:MouseEvent) : void
   {
      evt.stopImmediatePropagation();
      Child_searchFriend.instance.hide();
      UIManager.friendPanel.searchByName(this._vo.name);
   }
}
