package com.example.ahboard.board.domain;

import lombok.*;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardAttach {

    private String uuid;
    private Long bno;
    private String fileName;
    private String path;
    private boolean image;

    public void setBno(Long bno) {
        this.bno = bno;
    }
}
