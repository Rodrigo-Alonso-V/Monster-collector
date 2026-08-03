import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './users/user.module';
import { MonsterModule } from './monsters/monster.module';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [ MongooseModule.forRoot("mongodb://localhost:27017/monster-collector-db"),
    UserModule, MonsterModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
