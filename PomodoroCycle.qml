import QtQuick

QtObject {
    id: cycle
    property int focusCount: 0

    enum Phase {
        Focus,
        ShortBreak,
        LongBreak
    }
    property int currentPhase: PomodoroCycle.Phase.Focus

    function nextStep() {
        switch (currentPhase) {
        case PomodoroCycle.Phase.Focus:
            focusCount++
            if (focusCount == 4)
                currentPhase = PomodoroCycle.Phase.LongBreak
            else
                currentPhase = PomodoroCycle.Phase.ShortBreak
            break
        case PomodoroCycle.Phase.ShortBreak:
            currentPhase = PomodoroCycle.Phase.Focus
            break
        case PomodoroCycle.Phase.LongBreak:
            reset()
            break
        }
    }

    function currentMinutes() {
        switch (currentPhase) {
        case PomodoroCycle.Phase.Focus:
            return focus.currentValue
        case PomodoroCycle.Phase.ShortBreak:
            return shortBreak.currentValue
        case PomodoroCycle.Phase.LongBreak:
            return longBreak.currentValue
        }
    }

    function currentPhaseAsText(){
        switch (currentPhase) {
        case PomodoroCycle.Phase.Focus:
            return "focus"
        case PomodoroCycle.Phase.ShortBreak:
            return "short break"
        case PomodoroCycle.Phase.LongBreak:
            return "long break"
        }
    }

    function reset(){
        focusCount = 0
        currentPhase = PomodoroCycle.Phase.Focus
    }
}
