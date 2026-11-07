package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class XiLianJiNengPanel extends Panel
   {
      
      private const LEN:int = 5;
      
      private var btnChange:Button;
      
      private var btnXiLian:Button;
      
      private var vecChangeGrid:Vector.<View_Grid>;
      
      private var grid:View_Grid;
      
      private var spTip:Sprite;
      
      private var _index:int;
      
      private var nowGrid:View_Grid;
      
      private var _gridPosition:int;
      
      private var eff2:Effect;
      
      private var _freeTimes:int;
      
      private var _times:int;
      
      private var vecNullStar:Vector.<DisplayObject>;
      
      private var vecSolidStar:Vector.<DisplayObject>;
      
      private var vecziStar:Vector.<DisplayObject>;
      
      private var _data:Array;
      
      private var effArr:Vector.<Effect> = new Vector.<Effect>();
      
      public const SKILLARR:Array = [36301,36302,36303,36304,36305,36306,36307,36308,36310,36311,36313,36314,36315,36316,36317,36318,36319];
      
      private var firstTime:Boolean = true;
      
      public function XiLianJiNengPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var g:View_Grid = null;
         var d:DisplayObject = null;
         var i:uint = 0;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":398,
            "height":272
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":350,
            "height":222
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this,{
            "x":29,
            "y":99,
            "width":340,
            "height":78
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":364,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("10127",1),this,{
            "x":148,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("10128",1),this,{
            "x":116,
            "y":104,
            "color":14662240,
            "size":16,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("10129",1),this,{
            "x":130,
            "y":237,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.btnChange = ComponentUtil.getButton(LangConfig.getWord("10130",1),"Button_Four",this,{
            "x":113,
            "y":181,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnXiLian = ComponentUtil.getButton(LangConfig.getWord("10131",1),"Button_Four",this,{
            "x":213,
            "y":182,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnChange.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         this.btnXiLian.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.PET;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         this.grid.x = 211;
         this.grid.y = 52;
         addChild(this.grid);
         i = 6;
         this.vecChangeGrid = new Vector.<View_Grid>();
         this.vecNullStar = new Vector.<DisplayObject>(5,true);
         this.vecSolidStar = new Vector.<DisplayObject>(5,true);
         this.vecziStar = new Vector.<DisplayObject>(5,true);
         while(Boolean(i--))
         {
            g = new View_Grid();
            g.type = Enum_type_grid.PET;
            g.set_bmp_bg();
            g.set_bmp_select();
            g.set_bmp_over();
            g.x = 52 + (Const_png.SIZE_GRID + 12) * (5 - i);
            g.y = 132;
            addChild(g);
            this.vecChangeGrid.push(g);
            g.addEventListener(MouseEvent.CLICK,this.gridOnClick);
            if(i < this.LEN)
            {
               d = ComponentUtil.getDisplayObject("start20px_Default",this);
               d.x = 119 + (d.width + 12) * i;
               d.y = 211;
               this.vecNullStar[i] = d;
               d = ComponentUtil.getDisplayObject("start20px_yellow",this);
               d.x = 119 + (d.width + 12) * i;
               d.y = 211;
               this.vecSolidStar[i] = d;
               d = ComponentUtil.getDisplayObject("start20px_Zi",this);
               d.x = 119 + (d.width + 12) * i;
               d.y = 211;
               this.vecziStar[i] = d;
            }
         }
         this.spTip = new Sprite();
         this.spTip.graphics.beginFill(16777215,0);
         this.spTip.graphics.drawRect(0,0,168,22);
         this.spTip.graphics.endFill();
         addChild(this.spTip);
         this.spTip.x = 115;
         this.spTip.y = 205;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
      }
      
      protected function btnOnClick(e:MouseEvent) : void
      {
         switch((e.target as Button).label)
         {
            case LangConfig.getWord("10130",1):
               if(Boolean(this.nowGrid) && Boolean(this.nowGrid.vo))
               {
                  View_Alert.show(LangConfig.getWord("10132",1,this.nowGrid.vo.str_name),View_Alert.OK_CANCAL,function():void
                  {
                     PetCGMessage.CG_PET_JINGNENG_CHANGE(_gridPosition,nowGrid.vo.id);
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10133",1));
               break;
            case LangConfig.getWord("10134",1):
               UIManager.jiNengShuaxinPanel.show(this._index);
               break;
            case LangConfig.getWord("10131",1):
               if(Boolean(this._freeTimes))
               {
                  return;
               }
               PetCGMessage.CG_PET_JINGNENG_XILIAN(1,this._index);
         }
      }
      
      private function gridOnClick(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(this.nowGrid == grid)
         {
            return;
         }
         if(Boolean(this.nowGrid))
         {
            this.nowGrid.bSelect = false;
         }
         this.nowGrid = grid;
         this.nowGrid.bSelect = true;
      }
      
      public function show(vo:Vo_grid, gridPosition:int) : void
      {
         var v:Vo_Skill = null;
         this._gridPosition = gridPosition;
         if(Boolean(vo))
         {
            v = vo as Vo_Skill;
            v.bgIndex = v.current_grade + 1;
            this.grid.vo = v;
            TipManager.bind(this.grid,"<b><font color=\'#ffff00\'>" + v.str_name + "</font></b><br />" + v.effect_description);
         }
         else
         {
            TipManager.unBind(this.grid);
            this.grid.vo = null;
         }
         if(Boolean(this.eff2))
         {
            EffectManager.removeEffect(this.eff2);
            this.eff2 = null;
         }
         if(Boolean(vo))
         {
            if(this.SKILLARR.indexOf(vo.id) != -1)
            {
               this.eff2 = EffectManager.addEffect("35205",this,800,this.grid.x + 13,this.grid.y + 17,true);
            }
         }
      }
      
      public function updataBtn(freeTimes:int) : void
      {
         this._freeTimes = freeTimes;
         if(Boolean(this._freeTimes))
         {
            this.btnXiLian.label = LangConfig.getWord("10134",1);
         }
         else
         {
            this.btnXiLian.label = LangConfig.getWord("10131",1);
         }
      }
      
      public function updataStar(times:int) : void
      {
         var i:int = 0;
         var nums1:int = 0;
         var nums2:int = 0;
         var nums3:int = 0;
         this._times = times;
         i = this.LEN;
         TipManager.bind(this.spTip,LangConfig.getWord("10135",1,this._times));
         while(Boolean(i--))
         {
            if(!contains(this.vecNullStar[i]))
            {
               addChild(this.vecNullStar[i]);
               this.vecNullStar[i].x = 119 + (this.vecNullStar[i].width + 12) * i;
               this.vecNullStar[i].y = 211;
            }
            if(!contains(this.vecSolidStar[i]))
            {
               addChild(this.vecSolidStar[i]);
               this.vecSolidStar[i].x = 119 + (this.vecSolidStar[i].width + 12) * i;
               this.vecSolidStar[i].y = 211;
            }
            if(!contains(this.vecziStar[i]))
            {
               addChild(this.vecziStar[i]);
               this.vecziStar[i].x = 119 + (this.vecziStar[i].width + 12) * i;
               this.vecziStar[i].y = 211;
            }
         }
         addChildAt(this.spTip,numChildren - 1);
         if(this._times <= 120)
         {
            nums1 = this._times / 24;
            nums2 = this.LEN - nums1;
            nums3 = this.LEN;
            i = this.LEN;
         }
         else
         {
            nums1 = 5;
            nums2 = 0;
            nums3 = this.LEN - ((this._times - 120) / 60 > this.LEN ? this.LEN : int((this._times - 120) / 60));
            i = this.LEN;
         }
         while(Boolean(i--))
         {
            nums1--;
            nums2--;
            nums3--;
            if(nums1 > -1 && contains(this.vecNullStar[nums1]))
            {
               removeChild(this.vecNullStar[nums1]);
            }
            if(nums2 > -1 && contains(this.vecSolidStar[i]))
            {
               removeChild(this.vecSolidStar[i]);
            }
            if(nums3 > -1 && contains(this.vecziStar[i]))
            {
               removeChild(this.vecziStar[i]);
            }
         }
      }
      
      public function updataGrid(data:Array) : void
      {
         var vo:Vo_Skill = null;
         var eff:Effect = null;
         this.reset();
         this._data = data;
         var len:int = int(this._data.length);
         while(Boolean(this.effArr.length))
         {
            EffectManager.removeEffect(this.effArr[0]);
            this.effArr[0] = null;
            this.effArr.shift();
         }
         while(Boolean(len--))
         {
            if(Boolean(data[len]))
            {
               vo = new Vo_Skill(this._data[len]);
               vo.bgIndex = vo.current_grade + 1;
               this.vecChangeGrid[len].vo = vo;
               this.vecChangeGrid[len].set_bmp_bg(View_Grid.GRID_OPEN);
               TipManager.bind(this.vecChangeGrid[len],"<b><font color=\'#ffff00\'>" + vo.str_name + "</font></b><br />" + vo.effect_description);
               EffectManager.addEffect("35064",this,800,this.vecChangeGrid[len].x + 13,this.vecChangeGrid[len].y + 17);
               if(this.SKILLARR.indexOf(vo.id) != -1)
               {
                  eff = EffectManager.addEffect("35205",this,800,this.vecChangeGrid[len].x + 13,this.vecChangeGrid[len].y + 17,true);
                  this.effArr.push(eff);
               }
            }
         }
      }
      
      private function reset() : void
      {
         if(Boolean(this.nowGrid))
         {
            this.nowGrid.bSelect = false;
            this.nowGrid.vo = null;
            this.nowGrid = null;
         }
         var i:uint = 6;
         while(Boolean(i--))
         {
            this.vecChangeGrid[i].vo = null;
            this.vecChangeGrid[i].set_bmp_bg(View_Grid.GRID_LOCK);
            TipManager.unBind(this.vecChangeGrid[i]);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.reset();
            if(this.firstTime)
            {
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Title_WashSkill",new Bitmap(),{
                  "x":119,
                  "y":5
               },this);
               this.firstTime = false;
            }
         }
         else
         {
            UIManager.jiNengShuaxinPanel.visible = false;
         }
         while(Boolean(this.effArr.length))
         {
            EffectManager.removeEffect(this.effArr[0]);
            this.effArr[0] = null;
            this.effArr.shift();
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

