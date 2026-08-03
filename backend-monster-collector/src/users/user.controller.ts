import { Controller, Get, Post, Param } from "@nestjs/common";
import { UserService } from "./user.service";


@Controller('users')
export class UserController {
    constructor(private readonly userService: UserService) {}

    @Get('all')
    getAllUsers() {
        return this.userService.getAllUsers();
    }

    @Get('validate/:username')
    getValidateUser(@Param('username') username:string) {
        return this.userService.getValidateUser(username)
    }

    @Get('myId/:username')
    getMyId(@Param('username') username: string) {
        return this.userService.getMyId(username)
    }

    
    @Post('createUser/:username')
    postCreateUser(@Param('username') username:string) {
        return this.userService.postCreateUser(username)
    }
}
