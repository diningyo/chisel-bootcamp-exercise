import chisel3._
import chisel3.util._
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class MyDecoupledIO extends Module {
    val io = IO(new Bundle {
        val dcp = Decoupled(UInt(8.W))
    })

    val ctr = RegInit(2.U(2.W))
    val r = RegInit(0.U(8.W))

    val valid = (ctr === 0.U)
    val update = io.dcp.ready && valid

    when (update) {
        r := r + 1.U
    }

    when (ctr === 0.U) {
        when (valid) {
            ctr := 2.U
        }
    }.otherwise {
        ctr := ctr - 1.U
    }

    io.dcp.valid := valid
    io.dcp.bits := r
}
