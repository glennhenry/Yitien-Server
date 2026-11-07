package com.yiTian.view.modules.qiJu
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_List extends Sprite
   {
      
      private var listVec:Array;
      
      private var list:List;
      
      private var select_list:ComboBox;
      
      private var timeTF:MyTextField;
      
      private var buyTimeBtn:Button;
      
      private var type:int = -1;
      
      public function Child_List()
      {
         super();
         this.init();
      }
      
      public function setTime() : void
      {
         var tip:String = null;
         this.timeTF.text = Model_QiJu.qiJuGame_time + "/" + Model_QiJu.qiJuGame_count;
         if(Model_QiJu.qiJuGame_count == Enum_QiJu.MAX_TIME)
         {
            TipManager.bind(this.buyTimeBtn,"<font color =\'#FF9900\'>" + LangConfig.getWord("80200",8) + "</font>");
         }
         else
         {
            tip = LangConfig.getWord("80201",8,(Model_QiJu.qiJuGame_count - 1) * 200);
            TipManager.bind(this.buyTimeBtn,tip);
         }
      }
      
      public function showList() : void
      {
         this.list.reset();
         if(this.type == -1)
         {
            this.list.source = Model_QiJu.listVo;
         }
         else
         {
            this.list.source = QiJuHandler.getListSource(this.type);
         }
      }
      
      private function init() : void
      {
         ComponentUtil.getTextField(LangConfig.getWord("80119",8),this,{
            "x":53,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80120",8),this,{
            "x":120,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80121",8),this,{
            "x":191 - 16,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80122",8),this,{
            "x":237,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80123",8),this,{
            "x":329 - 35,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80180",8),this,{
            "x":120,
            "y":279,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.timeTF = ComponentUtil.getTextField("",this,{
            "x":225,
            "y":279,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
            "x":8,
            "y":277,
            "width":102,
            "height":24
         },Global.Img_Cdm);
         this.list = ComponentUtil.getList(350,247,QiJuItem,this,null,null,-1);
         this.list.scrollAutoType = ScrollAutoType.TO_TOP;
         addChild(this.list);
         ComponentUtil.setPropertie(this.list,{
            "x":0,
            "y":20
         });
         this.listVec = [];
         this.buyTimeBtn = ComponentUtil.getButton(LangConfig.getWord("80202",8),"Button_Four",this,{
            "x":255,
            "y":277,
            "textColor":16184781
         },Global.Img_Cdm);
         this.buyTimeBtn.callBack = this.buyTimeFun;
         this.getSource();
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.getSource);
      }
      
      private function buyTimeFun(event:MouseEvent) : void
      {
         var str:String;
         if(Model_QiJu.qiJuGame_count == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80200",8));
            return;
         }
         str = LangConfig.getWord("80203",8,(Model_QiJu.qiJuGame_count - 1) * 200);
         View_Alert.show(str,View_Alert.OK_CANCAL,function():void
         {
            if(GameUnitManager.hero.money < (Model_QiJu.qiJuGame_count - 1) * 200)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80205",8));
            }
            else
            {
               QiJuCGMessage.CG_QIJU_BUYTIME();
            }
         });
      }
      
      private function getSource() : void
      {
         var index:int = (GameUnitManager.hero.level - 80) / 5;
         var type:Array = Enum_QiJu.qiju_type.slice(0,index + 1);
         type.unshift(LangConfig.getWord("80125",8));
         var source:Array = [];
         var len:int = int(type.length);
         var i:int = 0;
         while(i < len)
         {
            if(i == 0)
            {
               source[i] = [type[i],i - 1];
            }
            else
            {
               source[i] = [type[i] + " " + Enum_QiJu.type_level[i - 1] + LangConfig.getWord("80126",8),i - 1];
            }
            i++;
         }
         if(!this.select_list)
         {
            this.select_list = new ComboBox(source,this.selListFun,100,"Button_PageDown","ComboBox_background","xuanze_over",120);
            addChild(this.select_list);
            ComponentUtil.setPropertie(this.select_list,{
               "x":8,
               "y":277
            });
            this.select_list.select(source[0][1]);
         }
         else
         {
            this.select_list.source = source;
         }
      }
      
      private function selListFun(value:int) : void
      {
         this.type = value;
         this.showList();
      }
   }
}

