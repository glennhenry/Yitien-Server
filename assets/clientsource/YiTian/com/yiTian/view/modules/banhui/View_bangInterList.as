package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.Vo_banghuiList;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BangCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class View_bangInterList extends Sprite
   {
      
      private static var desCripArr:Array;
      
      private static const posArr:Array = [40,149,310,437,538,620];
      
      private var minusBtn:Button;
      
      private var riseBtn:Button;
      
      private var pageTF:MyTextField;
      
      private var itemVec:Vector.<Item> = new Vector.<Item>();
      
      private var maxPage:int;
      
      private var curPage:int;
      
      private var totalPage:int;
      
      private var leftNum:int;
      
      public const LEN:int = 11;
      
      private var nowItem:Item;
      
      public function View_bangInterList()
      {
         var item:Item = null;
         var i:int = 0;
         super();
         desCripArr = [LangConfig.getWord("60001",6),LangConfig.getWord("60002",6),LangConfig.getWord("60003",6),LangConfig.getWord("60004",6),LangConfig.getWord("60005",6)];
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":33,
            "y":71,
            "width":662,
            "height":342
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":34,
            "y":72,
            "width":660,
            "height":20
         },Global.Img_Cdm);
         var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":322,
            "y":420,
            "width":78,
            "height":20
         },Global.Img_Cdm);
         var j:int = 0;
         while(j < 5)
         {
            ComponentUtil.getTextField(desCripArr[j],this,{
               "x":posArr[j],
               "y":72,
               "color":16764206,
               "size":12,
               "leading":0
            });
            j++;
         }
         this.minusBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":300,
            "y":420,
            "textColor":16184781,
            "name":"minus"
         },Global.Img_Cdm);
         this.riseBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":401,
            "y":420,
            "textColor":16184781,
            "name":"rise"
         },Global.Img_Cdm);
         this.curPage = 1;
         this.totalPage = 1;
         this.pageTF = ComponentUtil.getTextField("000/000",this,{
            "x":336,
            "y":422,
            "color":16773818,
            "size":12,
            "realWidth":50,
            "leading":0
         });
         this.pageTF.align = TextFormatAlign.CENTER;
         i = 0;
         while(i < this.LEN)
         {
            item = new Item();
            item.x = 36;
            item.y = 92 + 29 * i;
            item.addEventListener(MouseEvent.CLICK,this.cliHandle);
            addChild(item);
            item.visible = false;
            this.itemVec.push(item);
            i++;
         }
         this.minusBtn.callBack = this.changeHandle;
         this.riseBtn.callBack = this.changeHandle;
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         var temItem:Item = e.target as Item;
         if(!temItem)
         {
            return;
         }
         if(temItem == this.nowItem)
         {
            return;
         }
         if(Boolean(this.nowItem))
         {
            this.nowItem.select = false;
         }
         temItem.select = true;
         this.nowItem = temItem;
      }
      
      private function hide() : void
      {
         var i:int = 0;
         while(i < this.LEN)
         {
            this.itemVec[i].visible = false;
            i++;
         }
      }
      
      private function changeHandle(e:MouseEvent) : void
      {
         var name:String = (e.target as Button).name;
         switch(name)
         {
            case "minus":
               if(this.curPage > 1)
               {
                  --this.curPage;
               }
               break;
            case "rise":
               if(this.curPage < this.maxPage)
               {
                  ++this.curPage;
               }
         }
         if(Model_bang.partyType == 0)
         {
            BangCGMessage.CG_GET_BANG_LIST(this.curPage);
         }
         else
         {
            BangCGMessage.CG_BANG_CHECK_SELF(2,this.curPage);
         }
      }
      
      public function update(arr:Array, current_page:int, total_page:int, size:int) : void
      {
         var temItem:Item = null;
         var vo_listItem:Vo_banghuiList = null;
         this.pageTF.text = current_page + "/" + total_page;
         this.curPage = current_page;
         this.maxPage = total_page;
         this.hide();
         var j:int = 0;
         while(j < size)
         {
            temItem = this.itemVec[j];
            vo_listItem = arr[j];
            temItem.visible = true;
            temItem.updata(vo_listItem);
            j++;
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.data.vo.Vo_banghuiList;
import com.yiTian.manager.LangConfig;
import com.yiTian.net.message.cg.BangCGMessage;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flashx.textLayout.formats.TextAlign;

class Item extends Sprite
{
   
   private var rankTF:MyTextField;
   
   private var bangTF:MyTextField;
   
   private var hostTF:MyTextField;
   
   private var lvlTF:MyTextField;
   
   private var memTF:MyTextField;
   
   private var checkBtn:Button;
   
   private var partyId:Number;
   
   private var _str_bmp:DisplayObject;
   
   private var _select:Boolean;
   
   public function Item()
   {
      var spr:Sprite;
      var back1:ScaleBitmap;
      super();
      spr = new Sprite();
      spr.graphics.beginFill(0,0);
      spr.graphics.drawRect(0,0,646,26);
      spr.graphics.endFill();
      spr.mouseEnabled = false;
      addChild(spr);
      back1 = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":4,
         "y":26,
         "width":650,
         "height":2
      },Global.Img_Cdm);
      this._str_bmp = ComponentUtil.getDisplayObject("Item_Select",this,{
         "width":646,
         "height":26,
         "y":0
      });
      (this._str_bmp as Sprite).mouseEnabled = false;
      (this._str_bmp as Sprite).mouseChildren = false;
      this._str_bmp.visible = false;
      this.rankTF = ComponentUtil.getTextField("",this,{
         "x":5,
         "y":5,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.bangTF = ComponentUtil.getTextField("",this,{
         "x":102,
         "y":5,
         "color":11904647,
         "size":12,
         "leading":0,
         "realWidth":78,
         "align":TextAlign.CENTER
      });
      this.hostTF = ComponentUtil.getTextField("",this,{
         "x":250 - 30,
         "y":5,
         "color":11904647,
         "size":12,
         "leading":0,
         "realWidth":76 + 60,
         "align":TextAlign.CENTER
      });
      this.lvlTF = ComponentUtil.getTextField("",this,{
         "x":398,
         "y":5,
         "color":11904647,
         "size":12,
         "leading":0,
         "realWidth":33,
         "align":TextAlign.CENTER
      });
      this.memTF = ComponentUtil.getTextField("",this,{
         "x":500,
         "y":5,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.checkBtn = ComponentUtil.getButton(LangConfig.getWord("50029",5),"Button_TiliteFour",this,{
         "x":582,
         "y":5,
         "textColor":16184781
      },Global.Img_Cdm);
      addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
      addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
      this.checkBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
      {
         BangCGMessage.CG_BANG_CHECK(partyId);
      });
   }
   
   public function set select(value:Boolean) : void
   {
      this._select = value;
      this._str_bmp.visible = value;
   }
   
   private function overHandle(e:MouseEvent) : void
   {
      this._str_bmp.visible = true;
   }
   
   private function outHandle(e:MouseEvent) : void
   {
      if(!this._select)
      {
         this._str_bmp.visible = false;
      }
   }
   
   public function updata(vo:Vo_banghuiList) : void
   {
      this.rankTF.text = String(vo.paiming);
      this.bangTF.text = String(vo.bang_name);
      vo.bang_host = Model_heFu.repNameByHero(vo.bang_host);
      this.hostTF.text = String(vo.bang_host);
      this.lvlTF.text = String(vo.bang_level);
      this.partyId = vo.bang_id;
      this.memTF.text = vo.bang_members + "/" + vo.bang_members_lim;
   }
}
