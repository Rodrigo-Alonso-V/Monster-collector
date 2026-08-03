import { Schema, SchemaFactory, Prop } from "@nestjs/mongoose";
import { Document} from "mongoose";


@Schema({collection: "users"})
export class User extends Document {
    @Prop({required: true})
    username !: string

    @Prop({default: 1})
    level !: number

    @Prop({default: 0})
    coins !: number

}

export const userSchema = SchemaFactory.createForClass(User)