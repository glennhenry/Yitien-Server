package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   
   public class View_KuaFuPaiDui_rank extends Panel123
   {
      
      private static var _instance:View_KuaFuPaiDui_rank;
      
      private var findBack:Button;
      
      private var listArr:Array;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var curPage:int;
      
      public function View_KuaFuPaiDui_rank()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/KFPD.swf","KFPDdm");
      }
      
      public static function get instance() : View_KuaFuPaiDui_rank
      {
         if(!_instance)
         {
            _instance = new View_KuaFuPaiDui_rank();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var element:PHBM = null;
         bAutoRemove = false;
         this.curPage = 1;
         ComponentUtil.getBitmap("Back_PHB",this,{
            "x":0,
            "y":0
         },Global.KFPDdm);
         ComponentUtil.getTextField("注：舞步“？”号输入方向一致，触发默契度。",this,{
            "x":13,
            "y":370
         });
         this.findBack = ComponentUtil.getButton("","Button_ZHWB",this,{
            "x":98,
            "y":402,
            "textColor":16771436
         },Global.KFPDdm);
         this.findBack.callBack = function():void
         {
            if(Model_KuaFuPaiDui.lastPartner[0] != 0)
            {
               if(Boolean(GameUnitManager.findUnit(Model_KuaFuPaiDui.lastPartner[0],UnitType.PLAYER)))
               {
                  KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_INVITE(Model_KuaFuPaiDui.lastPartner[0],Model_KuaFuPaiDui.lastPartner[1]);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("舞伴不在房间内");
               }
            }
         };
         this.findBack.visible = false;
         this.listArr = [];
         i = 0;
         while(i < 6)
         {
            element = new PHBM();
            element.x = 20;
            element.y = 55 + i * 48;
            addChild(element);
            element.visible = false;
            this.listArr.push(element);
            i++;
         }
         ComponentUtil.getBitmap("Back_YSD",this,{
            "x":111,
            "y":347
         },Global.KFPDdm);
         this.prevBtn = ComponentUtil.getButton("","Button_SYY",this,{
            "x":82,
            "y":345,
            "textColor":16771436
         },Global.KFPDdm);
         this.prevBtn.enabled = false;
         this.prevBtn.callBack = this.changePage;
         this.nextBtn = ComponentUtil.getButton("","Button_XYY",this,{
            "x":174,
            "y":345,
            "textColor":16771436
         },Global.KFPDdm);
         this.nextBtn.callBack = this.changePage;
         this.pageTxt = ComponentUtil.getTextField("1/2",this,{
            "x":137,
            "y":347,
            "color":16777215,
            "size":12,
            "leading":0,
            "autoSize":"center"
         });
         Global.control.registerCallBack(Enum_KuaFuPaiDui.BREAK_UP,this.showFindBackBtn);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.INVITE_SUCCEED,this.hideFindBackBtn);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.CHANGE_ROOM,this.hideFindBackBtn);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.ENTER,this.hideFindBackBtn);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.SET_MY_RANK,this.setMyRank);
      }
      
      private function showFindBackBtn(e:* = null) : void
      {
         if(Model_KuaFuPaiDui.lastPartner[0] != 0)
         {
            this.findBack.visible = true;
         }
      }
      
      private function hideFindBackBtn(e:* = null) : void
      {
         this.findBack.visible = false;
      }
      
      private function changePage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            --this.curPage;
            this.nextBtn.enabled = true;
            if(this.curPage == 1)
            {
               this.prevBtn.enabled = false;
            }
         }
         else
         {
            ++this.curPage;
            this.prevBtn.enabled = true;
            if(this.curPage == 2)
            {
               this.nextBtn.enabled = false;
            }
         }
         this.pageTxt.text = this.curPage + "/2";
         this.setRank();
      }
      
      public function setRank() : void
      {
         var strArr:Array = null;
         var i:int = (this.curPage - 1) * 5;
         while(i < (this.curPage - 1) * 5 + 5)
         {
            if(Boolean(Model_KuaFuPaiDui.rankList[i]))
            {
               this.listArr[i % 5].visible = true;
               strArr = Model_KuaFuPaiDui.rankList[i].split("_");
               this.listArr[i % 5].setRank([i + 1,strArr[0],strArr[1],strArr[2]]);
            }
            else
            {
               this.listArr[i % 5].visible = false;
            }
            i++;
         }
      }
      
      private function setMyRank(arr:Array) : void
      {
         var t_arr:Array = null;
         Model_KuaFuPaiDui.myRank = arr;
         if(Model_KuaFuPaiDui.myRank.length > 0)
         {
            this.listArr[5].visible = true;
            t_arr = Model_KuaFuPaiDui.myRank[1].split("_");
            this.listArr[5].setRank([Model_KuaFuPaiDui.myRank[0],t_arr[0],t_arr[1],Model_KuaFuPaiDui.myRank[2]]);
         }
         else
         {
            this.listArr[5].visible = false;
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = 200;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_shop;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.TipManager;
import com.yiTian.utils.HtmlUtil;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class PHBM extends Sprite
{
   
   private var rank:MyTextField;
   
   private var name1:MyTextField;
   
   private var name2:MyTextField;
   
   private var score:MyTextField;
   
   private var bm1:Bitmap;
   
   private var bm2:Bitmap;
   
   private var bm3:Bitmap;
   
   private var giftTxt:MyTextField;
   
   private var giftVo:Vo_item;
   
   public function PHBM()
   {
      super();
      this.bm1 = ComponentUtil.getBitmap("Icon_ZiWu",this,{
         "x":17,
         "y":11
      },Global.KFPDdm);
      this.bm2 = ComponentUtil.getBitmap("Icon_LanWu",this,{
         "x":17,
         "y":11
      },Global.KFPDdm);
      this.bm3 = ComponentUtil.getBitmap("Icon_LvWu",this,{
         "x":17,
         "y":11
      },Global.KFPDdm);
      this.rank = ComponentUtil.getTextField("1",this,{
         "x":0,
         "y":10,
         "color":13424242,
         "size":12,
         "leading":0
      });
      this.name1 = ComponentUtil.getTextField("????",this,{
         "x":117,
         "y":0,
         "color":327424,
         "size":12,
         "leading":0,
         "autoSize":"center"
      });
      this.name2 = ComponentUtil.getTextField("????",this,{
         "x":117,
         "y":21,
         "color":14566855,
         "size":12,
         "leading":0,
         "autoSize":"center"
      });
      this.score = ComponentUtil.getTextField("????",this,{
         "x":210,
         "y":3,
         "color":13424242,
         "size":12,
         "leading":0,
         "autoSize":"center"
      });
      this.giftVo = new Vo_item();
      this.giftTxt = ComponentUtil.getTextField("舞圣礼包",this,{
         "x":210,
         "y":17
      },"center");
      this.giftTxt.mouseEnabled = true;
      this.giftTxt.addEventListener(MouseEvent.ROLL_OVER,this.showVo);
      this.giftTxt.addEventListener(MouseEvent.ROLL_OUT,this.hideVo);
   }
   
   private function showVo(e:MouseEvent) : void
   {
      TipManager.update(this.giftVo);
      TipManager.view_tip.x = Global.stage.mouseX + TipManager.view_tip.width > Global.stage.stageWidth ? Global.stage.stageWidth - TipManager.view_tip.width : Global.stage.mouseX;
      TipManager.view_tip.y = Global.stage.mouseY + TipManager.view_tip.height > Global.stage.stageHeight ? Global.stage.stageHeight - TipManager.view_tip.height : Global.stage.mouseY;
   }
   
   private function hideVo(e:MouseEvent) : void
   {
      TipManager.hide();
   }
   
   public function setRank(arr:Array) : void
   {
      this.rank.text = arr[0];
      this.name1.text = arr[1];
      this.name2.text = arr[2];
      this.score.text = arr[3];
      this.bm1.visible = false;
      this.bm2.visible = false;
      this.bm3.visible = false;
      switch(arr[0])
      {
         case 1:
            this.bm1.visible = true;
            this.giftTxt.htmlText = HtmlUtil.font("舞圣礼包",Model_shop.get_color_arr[4]);
            this.giftVo.id = 45243;
            this.giftVo.Init_lib();
            break;
         case 2:
            this.bm2.visible = true;
            this.giftTxt.htmlText = HtmlUtil.font("舞神礼包",Model_shop.get_color_arr[3]);
            this.giftVo.id = 45244;
            this.giftVo.Init_lib();
            break;
         case 3:
            this.bm3.visible = true;
            this.giftTxt.htmlText = HtmlUtil.font("舞神礼包",Model_shop.get_color_arr[3]);
            this.giftVo.id = 45244;
            this.giftVo.Init_lib();
            break;
         case 4:
         case 5:
            this.giftTxt.htmlText = HtmlUtil.font("舞皇礼包",Model_shop.get_color_arr[2]);
            this.giftVo.id = 45245;
            this.giftVo.Init_lib();
            break;
         default:
            this.giftTxt.htmlText = HtmlUtil.font("舞者礼包",Model_shop.get_color_arr[1]);
            this.giftVo.id = 45246;
            this.giftVo.Init_lib();
      }
   }
}
