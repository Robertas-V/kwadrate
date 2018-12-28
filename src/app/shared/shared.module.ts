import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FlexLayoutModule } from '@angular/flex-layout';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';

@NgModule({
    imports: [CommonModule],
    exports: [FlexLayoutModule, MatToolbarModule, MatIconModule]
})
export class SharedModule {}
