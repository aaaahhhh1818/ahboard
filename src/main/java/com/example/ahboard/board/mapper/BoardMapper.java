package com.example.ahboard.board.mapper;

import com.example.ahboard.board.domain.Board;
import com.example.ahboard.board.domain.BoardAttach;
import com.example.ahboard.common.dto.PageRequestDTO;

import java.util.List;

public interface BoardMapper {

    void insert(Board board);

    List<Board> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Board select(Long bno);

    int delete(Long bno);

    int update(Board board);

    int insertAttach(BoardAttach attach);

    int deleteAttach(Long bno);
}
