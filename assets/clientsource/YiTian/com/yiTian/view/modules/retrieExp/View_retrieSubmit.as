package com.yiTian.view.modules.retrieExp
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RetrieExpCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_retrieSubmit extends Panel123
   {
      
      private var bg:ScaleBitmap;
      
      private var titleBg:Bitmap;
      
      private var tf_exp:MyTextField;
      
      private var tf_costMoney:MyTextField;
      
      private var gridVec:Vector.<View_Grid>;
      
      private var btn_ok:Button;
      
      private var btn_notUse:Button;
      
      private const grid_count:int = 4;
      
      private var _selectedIndex:int = 0;
      
      private var sp_selected:Sprite;
      
      private const token_percent:Array = [1,1.25,1.5,1.75,2];
      
      private var _vo:Object;
      
      private var _precent:Number = 0;
      
      private var _percent:Number = 1;
      
      public function View_retrieSubmit()
      {
         super();
         regResource("Title_JYZH","JYZH_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var bm_selected:Bitmap = null;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":398,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":350,
            "height":180
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":364,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60264",6),this,{
            "x":140,
            "y":50,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.tf_exp = ComponentUtil.getTextField("",this,{
            "x":217,
            "y":50
         });
         this.tf_exp.color = 14013809;
         ComponentUtil.getTextField(LangConfig.getWord("60265",6),this,{
            "x":69,
            "y":80,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60266",6),this,{
            "x":258,
            "y":80,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.tf_costMoney = ComponentUtil.getTextField("",this,{
            "x":322,
            "y":80
         });
         this.tf_costMoney.color = 16755712;
         ComponentUtil.getTextField("1.25" + "倍经验",this,{
            "x":48,
            "y":150,
            "color":15658734
         });
         ComponentUtil.getTextField("1.5" + "倍经验",this,{
            "x":130,
            "y":150,
            "color":15658734
         });
         ComponentUtil.getTextField("1.75" + "倍经验",this,{
            "x":203,
            "y":150,
            "color":15658734
         });
         ComponentUtil.getTextField("2" + "倍经验",this,{
            "x":287,
            "y":150,
            "color":15658734
         });
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Five",this,{
            "x":75,
            "y":180,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_ok.textColor = this.btn_ok.textOverColor = 13434624;
         this.btn_notUse = ComponentUtil.getButton(LangConfig.getWord("29142",2),"Button_Five",this,{
            "x":240,
            "y":180,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_notUse.textColor = this.btn_notUse.textOverColor = 8444772;
         bm_selected = Utils.getLoadBitmap("resource/image/iconBg/over.png",bm_selected,{
            "x":-3,
            "y":-3
         });
         this.sp_selected = new Sprite();
         this.sp_selected.addChild(bm_selected);
         this.createGrid(this.grid_count);
         this.titleBg = ComponentUtil.getBitmap("Title_JYZH",this,{
            "x":119,
            "y":5
         },Global.JYZH_Imgsdm);
         initDynamicView();
         this.btn_ok.callBack = this.okClickHandle;
         this.btn_notUse.callBack = this.notUseClickHandle;
      }
      
      private function okClickHandle(evt:MouseEvent) : void
      {
         if(this._selectedIndex <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29143",2));
            return;
         }
         if(GameUnitManager.hero.money < this._vo.moneyCost)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23434",2));
            return;
         }
         var target:View_Grid = this.gridVec[this._selectedIndex - 1];
         RetrieExpCGMessage.CG_RETRIEEXP1(this._vo.type,this._vo.date,target.vo.gridId);
         this.visible = false;
      }
      
      private function notUseClickHandle(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < this._vo.moneyCost)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23434",2));
            return;
         }
         RetrieExpCGMessage.CG_RETRIEEXP1(this._vo.type,this._vo.date,0);
         this.visible = false;
      }
      
      private function createGrid(count:int) : void
      {
         var posY:Number = NaN;
         var index:int = 0;
         var grid:View_Grid = null;
         this.gridVec = new Vector.<View_Grid>();
         posY = 105;
         index = 0;
         while(index < count)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg();
            grid.set_bmp_over(true);
            grid.set_tf_count(true,true,true);
            grid.x = 64 + index * 77;
            grid.y = posY;
            grid.tabIndex = index + 1;
            addChild(grid);
            grid.addEventListener(MouseEvent.CLICK,this.gridClickHandle);
            this.gridVec.push(grid);
            index++;
         }
      }
      
      private function gridClickHandle(evt:MouseEvent) : void
      {
         var target:View_Grid = evt.target as View_Grid;
         if(target.vo.count <= 0)
         {
            return;
         }
         this._selectedIndex = target.tabIndex;
         target.addChild(this.sp_selected);
         this.tf_exp.text = Math.round(this._vo.exp * this._percent * this.token_percent[this._selectedIndex]).toString();
      }
      
      public function showGrid() : void
      {
         var vo_va:Vo_valuable = null;
         var count:int = 0;
         var vo_vaa:Vo_valuable = null;
         var vo:Vo_item = null;
         var von:Vo_item = null;
         if(!this._vo)
         {
            return;
         }
         var vec1:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[46252]);
         var vec2:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[46253]);
         var vec3:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[46254]);
         var vec4:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[46255]);
         var vecvec:Vector.<Vector.<Vo_valuable>> = new Vector.<Vector.<Vo_valuable>>();
         vecvec.push(vec1,vec2,vec3,vec4);
         var index:int = 0;
         while(index < this.grid_count)
         {
            if(!vecvec[index] || vecvec[index].length <= 0)
            {
               von = new Vo_item();
               von.id = Enum_retrieExp.TOKENID[index];
               von.count = 0;
               von.Init_lib();
               this.gridVec[index].vo = von;
            }
            else
            {
               this.gridVec[index].mouseEnabled = true;
               vo_va = vecvec[index][0];
               count = 0;
               for each(vo_vaa in vecvec[index])
               {
                  count += vo_vaa.count;
               }
               vo = new Vo_item();
               vo.id = vo_va.id;
               vo.count = count;
               vo.gridId = vo_va.gridId;
               vo.Init_lib();
               this.gridVec[index].vo = vo;
               this.gridVec[index].addChild(this.sp_selected);
               this._selectedIndex = this.gridVec[index].tabIndex;
            }
            index++;
         }
         this.tf_exp.text = Math.round(this._vo.exp * this._percent * this.token_percent[this._selectedIndex]).toString();
      }
      
      public function show(obj:Object, percent:Number) : void
      {
         this._vo = obj;
         this._percent = percent;
         this.showGrid();
         this.tf_exp.text = Math.round(obj.exp * percent * this.token_percent[this._selectedIndex]).toString();
         this.tf_costMoney.text = obj.moneyCost.toString();
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            this._selectedIndex = 0;
            if(Boolean(this.sp_selected.parent))
            {
               this.sp_selected.parent.removeChild(this.sp_selected);
            }
         }
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
   }
}

