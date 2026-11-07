package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_updata_panelTip extends Sprite
   {
      
      private static var tx:int;
      
      private static var ty:int;
      
      public static var pool:Array = [];
      
      public static var voArrVec:Vector.<Vo_valuable> = new Vector.<Vo_valuable>();
      
      public static var saveData:Array = new Array();
      
      private var tf_tip:MyTextField;
      
      private var tf_name:MyTextField;
      
      private var grid:View_Grid;
      
      private var bg:Sprite;
      
      private var btn_close:Button;
      
      private var btn_ok:Button;
      
      private var moveBars:Sprite;
      
      public function View_updata_panelTip()
      {
         this.moveBars = new Sprite();
         super();
         this.bg = new Sprite();
         this.bg.graphics.beginFill(0,0);
         this.bg.graphics.drawRect(0,0,270,170);
         this.bg.graphics.endFill();
         addChild(this.bg);
         this.bg.visible = false;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":174
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":253,
            "height":124
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":70,
            "y":5
         },Global.Img_Cdm);
         this.move = new Rectangle(0,0,268,36);
         this.btn_close = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_close.addEventListener(MouseEvent.CLICK,function():void
         {
            if(GameUnitManager.hero.level < 30)
            {
               CLICK_BTN_OK(null);
            }
            visible = false;
         });
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":147,
            "y":53
         });
         this.tf_tip = ComponentUtil.getTextField("",this,{
            "x":58 + 85,
            "y":94,
            "color":16773818
         });
         this.tf_tip.autoSize = TextFieldAutoSize.CENTER;
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.x = 102;
         this.grid.y = 50;
         addChild(this.grid);
         tx = Global.stage.stageWidth - 380;
         ty = Global.stage.stageHeight - 260;
         addEventListener(MouseEvent.MOUSE_DOWN,this.setDownHd);
         this.btn_ok = ComponentUtil.getButton("","Button_Four",this,{
            "x":114,
            "y":126,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_ok.addEventListener(MouseEvent.CLICK,this.CLICK_BTN_OK);
      }
      
      public static function getInstance() : View_updata_panelTip
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new View_updata_panelTip();
      }
      
      public static function resetPosition() : void
      {
         var data:View_updata_panelTip = null;
         if(Boolean(saveData.length))
         {
            for each(data in saveData)
            {
               data.resetPostion();
            }
         }
      }
      
      private function bool(_type:int, voE:Vector.<Vo_equip>, strength:int) : Boolean
      {
         var vo_ep:Vo_equip = null;
         var i:int = 0;
         while(i < voE.length)
         {
            vo_ep = voE[i];
            if(_type == 9)
            {
               if(i == 8 || i == 9)
               {
                  if(!vo_ep || vo_ep.strength < strength)
                  {
                     return true;
                  }
                  if(Boolean(vo_ep) && Boolean(vo_ep.strength >= strength) && i == 9)
                  {
                     return false;
                  }
               }
            }
            else if(Boolean(vo_ep) && Boolean(vo_ep.type == _type) && vo_ep.strength > strength)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         var vo:Vo_valuable = null;
         var eVec:Vector.<Vo_equip> = null;
         var _type:int = 0;
         vo = this.grid.vo as Vo_valuable;
         if(vo is Vo_equip)
         {
            eVec = CommandManager.get_role_vec_equip();
            _type = vo.type;
            if(!this.bool(vo.type,eVec,(vo as Vo_equip).strength))
            {
               this.visible = false;
               return;
            }
            BagCGMessage.CG_BAG_EQUIP_ID_SERVER(vo.id_server);
         }
         else if(vo is Vo_item)
         {
            if(vo.type == Enum_item_type.BOOK_SKILL_UP)
            {
               UIManager.skillPanel.visible = true;
               UIManager.skillPanel.update_choose(vo);
            }
            else if(vo.type == Enum_item_type.MERIDIAN_PILL)
            {
               UIManager.rolePanel.openView(Enum_panel_role.MERIDIAN);
            }
            else if(vo.type == Enum_item_type.FUYUAN_WAWA)
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            }
            else if(vo.type == 423)
            {
               UIManager.num_valuable.Show(vo,View_num_valuable.BAG_USE_ITEM);
            }
            else
            {
               BagCGMessage.CG_BAG_ITEM_ID(vo.id,vo.bBind ? 1 : 0);
            }
         }
         this.visible = false;
      }
      
      private function setDownHd(e:MouseEvent) : void
      {
         if(Boolean(parent))
         {
            parent.setChildIndex(this,parent.numChildren - 1);
         }
      }
      
      public function updata_vo(_vo:Vo_valuable) : void
      {
         var str:String = null;
         this.visible = true;
         this.grid.vo = _vo;
         voArrVec.push(_vo);
         saveData.push(this);
         GameScene.uiLayer.addChild(this);
         if(_vo.color == Enum_color.WHITE)
         {
            str = ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         else if(_vo.color == Enum_color.GREEN)
         {
            str = ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         else if(_vo.color == Enum_color.BLUE)
         {
            str = ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         else if(_vo.color == Enum_color.PURPLE)
         {
            str = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         else if(_vo.color == Enum_color.ORANGE)
         {
            str = ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         else if(_vo.color == Enum_color.ANJIN)
         {
            str = ColorConstant.getColorStr(ColorConstant.ANJIN);
         }
         if(Global.pf == "qqgame")
         {
            if(_vo.str_name == LangConfig.getWord("60245",6))
            {
               _vo.str_name = LangConfig.getWord("60246",6);
            }
         }
         this.tf_name.htmlText = HtmlUtil.font(_vo.str_name,str,14);
         var vo:Vo_valuable = this.grid.vo as Vo_valuable;
         if(vo is Vo_equip)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("921",0));
            this.tf_tip.htmlText = LangConfig.getWord("922",0);
         }
         else if(vo.type == Enum_item_type.BOOK_SKILL)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("923",0));
            this.tf_tip.htmlText = LangConfig.getWord("924",0);
         }
         else if(vo.type == Enum_item_type.BOOK_SKILL_UP)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("925",0));
            this.tf_tip.htmlText = LangConfig.getWord("926",0);
         }
         else if(vo.type == Enum_item_type.MERIDIAN_PILL)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("927",0));
            this.tf_tip.htmlText = LangConfig.getWord("928",0);
         }
         else
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("929",0));
            this.tf_tip.htmlText = LangConfig.getWord("930",0);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         if(value)
         {
            super.visible = true;
            Tween.to(this,500,{
               "x":[Global.stage.stageWidth,tx],
               "y":[Global.stage.stageHeight,ty]
            });
         }
         else
         {
            if(Boolean(voArrVec.length))
            {
               i = 0;
               while(i < voArrVec.length)
               {
                  if(voArrVec[i] == this.grid.vo)
                  {
                     voArrVec.splice(i,1);
                  }
                  i++;
               }
            }
            Tween.to(this,200,{
               "y":[this.y,this.y + 150],
               "alpha":[1,0]
            },this.comp);
         }
      }
      
      private function comp() : void
      {
         super.visible = false;
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
      }
      
      public function set move(rect:Rectangle) : void
      {
         this.moveBars.graphics.beginFill(0,0);
         this.moveBars.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
         addChild(this.moveBars);
         this.moveBars.addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
         this.moveBars.addEventListener(MouseEvent.MOUSE_UP,this.upHd);
      }
      
      private function downHd(e:MouseEvent) : void
      {
         startDrag();
      }
      
      private function upHd(e:MouseEvent) : void
      {
         stopDrag();
      }
      
      public function resetPostion() : void
      {
         x = Global.stage.stageWidth - 380;
         y = Global.stage.stageHeight - 260;
      }
      
      public function dispose() : void
      {
         this.visible = false;
         this.tf_tip.text = "";
         this.tf_name.text = "";
         this.grid.vo = null;
      }
   }
}

