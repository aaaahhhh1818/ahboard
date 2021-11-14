package com.example.ahboard.board.service;

import com.example.ahboard.board.domain.Board;
import com.example.ahboard.board.dto.BoardDTO;
import com.example.ahboard.board.mapper.BoardMapper;
import com.example.ahboard.common.dto.PageRequestDTO;
import com.example.ahboard.common.dto.PageResponseDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardServiceImpl implements com.example.ahboard.board.service.BoardService {

    private final BoardMapper boardMapper; // 자동으로 주입해줌

    @Override
    public Long register(BoardDTO boardDTO) {

        Board board = boardDTO.getDomain();

        boardMapper.insert(board);

        Long bno = board.getBno();

        board.getAttachList().forEach(attach -> {
            attach.setBno(bno);
            boardMapper.insertAttach(attach);
        });

        return board.getBno();
    }

    @Override
    public PageResponseDTO<BoardDTO> getDTOList(PageRequestDTO pageRequestDTO) {

        List<BoardDTO> dtoList = boardMapper.getList(pageRequestDTO).stream().map(board -> board.getDTO()).collect(Collectors.toList());
        int count = boardMapper.getCount(pageRequestDTO);

        PageResponseDTO<BoardDTO> pageResponseDTO = PageResponseDTO.<BoardDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;

    }

    @Override
    public BoardDTO read(Long bno) {
        Board board = boardMapper.select(bno);

        if(board != null) {
            return board.getDTO();
        }
        return null;

    }

    @Override
    public boolean remove(Long bno) {
        return boardMapper.delete(bno) > 0;
    }

    @Override
    public boolean modify(BoardDTO boardDTO) {

        boardMapper.deleteAttach(boardDTO.getBno());

        Board board = boardDTO.getDomain();

        Long bno = board.getBno();

        board.getAttachList().forEach(attach -> {
            attach.setBno(bno);
            boardMapper.insertAttach(attach);
        });

        return boardMapper.update(board) > 0;
    }

}
