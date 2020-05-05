class Object {
    class AttributeCategories {
        class State {
			displayName="$STR_3DEN_Object_AttributeCategory_State";
			class Attributes {
				class Lock {
					data="lock";
					control="Lock";
					displayName="$STR_3DEN_Object_Attribute_Lock_displayName";
					tooltip="$STR_3DEN_Object_Attribute_Lock_tooltip";
					wikiType="[[Number]]";
				};
				class Skill {
					data="skill";
					control="Skill";
					displayName="$STR_3DEN_Object_Attribute_Skill_displayName";
					tooltip="$STR_3DEN_Object_Attribute_Skill_tooltip";
					wikiType="[[Number]]";
				};
				class Health {
					data="Health";
					control="Slider";
					displayName="$STR_3DEN_Object_Attribute_Health_displayName";
					tooltip="$STR_3DEN_Object_Attribute_Health_tooltip";
					wikiType="[[Number]]";
				};
				class Fuel {
					data="fuel";
					control="Slider";
					displayName="$STR_3DEN_Object_Attribute_Fuel_displayName";
					tooltip="$STR_3DEN_Object_Attribute_Fuel_tooltip";
					wikiType="[[Number]]";
				};
				class Ammo {
					data="ammo";
					control="Slider";
					displayName="$STR_3DEN_Object_Attribute_Ammo_displayName";
					tooltip="$STR_3DEN_Object_Attribute_Ammo_tooltip";
					wikiType="[[Number]]";
				};
				class Rank {
					data="rank";
					control="Rank";
					displayName="$STR_3DEN_Object_Attribute_Rank_displayName";
					tooltip="$STR_3DEN_Object_Attribute_Rank_tooltip";
					wikiType="[[String]]";
				};
				class UnitPos {
                    data="unitPos";
    				control="UnitPos";
                    expression="_this setVariable ['%s',_value,true];";
    				displayName="$STR_3DEN_Object_Attribute_Stance_displayName";
                    tooltip="custom stance";
    				condition="objectBrain";
				};
                class UnitPos2 {
                    data="unitPos2";
    				control="UnitPos";
                    expression="_this setVariable ['%s',_value,true];";
    				displayName="$STR_3DEN_Object_Attribute_Stance_displayName";
                    tooltip="custom stance";
    				condition="objectBrain";
				};
			};
		};
    };
};