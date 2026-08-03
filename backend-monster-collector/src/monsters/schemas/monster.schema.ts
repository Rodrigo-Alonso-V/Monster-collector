import { Schema, SchemaFactory, Prop } from "@nestjs/mongoose";
import { Document, Types } from "mongoose";

@Schema({collection: "monsters"})
export class Monster extends Document {
    @Prop({required: true})
    name !: string

    @Prop({default: 1})
    level !: number

    @Prop({required: true})
    owner !: Types.ObjectId
}

export const monsterSchema = SchemaFactory.createForClass(Monster)